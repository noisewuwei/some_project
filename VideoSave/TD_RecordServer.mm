//
//  TD_CentralServer.m
//  ToDesk_Service
//
//  Created by 海南有趣 on 2020/11/2.
//  Copyright © 2020 rayootech. All rights reserved.
//

#include <string.h>
#import "ForwardHead.h"
#import "TD_RecordServer.h"
#import "TD_EncryptorFactory.h"

#import "YMProxySocket.h"

#import "transit_protocol.h"

#import "YYModel.h"
#import "GCDAsyncSocket.h"

#import "TD_ScreenNetworkList.h"
#import "TD_ScreenNetwork.h"
#import "Center.pbObjc.h"

typedef void (^completionBlock)();

@interface TD_RecordServer () <GCDAsyncSocketDelegate>
{
    NSInteger _connectFailCount; // 连接错误的次数
    NSArray <NSString *> * _ips; // 解析出来的其他IP
    NSInteger _ipsIndex;
}

@property (strong, nonatomic) GCDAsyncSocket * socket;
@property (strong, nonatomic) YMProxySocket  * s5_socket;
@property (strong, nonatomic) GCDAsyncSocket * nor_socket;

@property (strong, nonatomic) dispatch_queue_t socketQueue;         // 发数据的串行队列
//@property (strong, nonatomic) dispatch_queue_t receiveQueue;        // 收数据处理的串行队列
@property (strong, nonatomic) NSString *ip;
@property (assign, nonatomic) UInt16 port;

@property (strong, nonatomic) completionBlock completion;           // 负载均衡结果回调

@property (strong, nonatomic) NSMutableData *buffer;            // 接收缓冲区

/// 服务器状态
@property (assign, nonatomic) kServiceStauts serviceStatus;

@property (strong, nonatomic) TD_EncryptorFactory * dnsEncrypt;

@property (assign, nonatomic) int ready;

@end

@implementation TD_RecordServer

// 超时时间, 超时会关闭 socket
static NSTimeInterval TimeOut = -1;

- (void)dealloc {
    
}

static TD_RecordServer * instance;
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TD_RecordServer alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.buffer = [[NSMutableData alloc] init];
        [self.buffer setLength:0];
        self.networkStatus = true;      // 首次运行认为有网络，因为 NetWorkManager 启动要时间，假如没网会超时返回
        
        self.ready = 0;
        
    }
    return self;
}

#pragma mark socket
/// 重置socket
- (void)resetSocket {
    [self disConnect];
    
    if ([TD_UserDefalt share].openProxy) {
        NSString * host = [TD_UserDefalt share].proxyHost;
        NSInteger port  = [TD_UserDefalt share].proxyPort;
        NSString * userName = [TD_UserDefalt share].proxyUserName;
        NSString * password = [TD_UserDefalt share].proxyPassword;
        self.s5_socket = [[YMProxySocket alloc] initWithDelegate:self delegateQueue:self.socketQueue];
        if (userName.length > 0) {
            [self.s5_socket setProxyHost:host proxyPort:port userName:userName password:password version:kSocksVersion5];
        } else {
            [self.s5_socket setProxyHost:host proxyPort:port version:kSocksVersion5];
        }
        
        self.s5_socket.IPv6Enabled = true;
        self.s5_socket.IPv4Enabled = true;
        self.s5_socket.IPv4PreferredOverIPv6 = false;
        self.socket = self.s5_socket;
        
        DLog(@"user proxy [%@:%ld]", host, port);
    } else {
        self.nor_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:self.socketQueue];
        self.nor_socket.IPv6Enabled = true;
        self.nor_socket.IPv4Enabled = true;
        self.nor_socket.IPv4PreferredOverIPv6 = false;     // 4 优先
        self.socket = self.nor_socket;
    }
}

/// 断开并清空socket
- (void)disConnect {
    self.serviceStatus = kServiceStauts_Disconnected;
    
    [self.socket disconnect];
    self.socket = nil;
    self.socketQueue = nil;
    
    [self.nor_socket disconnect];
    self.nor_socket = nil;
    [self.s5_socket disconnect];
    self.s5_socket = nil;
}

#pragma mark server
/// 登录record服务器
- (void)connectRecordSever {
    
    TD_ScreenNetwork * network = [[[TD_ScreenNetworkList share] screenNetworks] firstObject];
    
    [self resetSocket];
    
    self.serviceStatus = kServiceStauts_Connecting;
    
    self.ip = @"42.240.140.184";
    self.port = network.connectResult.recordserverport;
    
    NSError *error = nil;
    BOOL success = [self.socket connectToHost:self.ip onPort:self.port viaInterface:@"" withTimeout:10 error:&error];
    if (error != nil || !success) {
        _connectFailCount++;
        self.serviceStatus = kServiceStauts_Normal;
        DLog(@"record connect to %@:%d error:%@", self.ip, self.port, error);
    } else {
        DLog(@"record connect to %@:%d", self.ip, self.port);
    }
}

#pragma mark 中央服务器连接相关
/// 发送登录中央服务器的用户信息
- (void)toAuth {
    
    TD_ScreenNetwork * network = [[[TD_ScreenNetworkList share] screenNetworks] firstObject];
    
    dispatch_async(self.socketQueue, ^{
    
        RLogin *lmsg = [RLogin message];
        lmsg.rtoken = network.connectResult.recordtoken;
        lmsg.rdestid = network.targetID;
        lmsg.rid = [[TD_ClientInstance share] deviceID];
        
        NSData *msgData = [lmsg data]; //转为data
        
        [self sendMsg:1 msgData:msgData];
    });
}


#pragma mark 数据发送
- (void)send:(NSData *)data {
    dispatch_async(self.socketQueue, ^{
        // 无网络直接返回
        if (self.networkStatus == false) {
            return ;
        }
        
        // 如果不是登录包，不是心跳包, 并且没登录，可以自动登录，先自动登录，登录失败返回错误
        if (self.status == false && data != nil) {
            return ;
        }
  
        [self.socket readDataWithTimeout:TimeOut tag:1000];           // 每次都要设置接收数据的时间, tag
        [self.socket writeData:data withTimeout:TimeOut tag:1000];    // 再发送
        
    });
}

/// 发送数据
/// @param msgid   数据ID
/// @param msgData 数据
- (void)sendMsg:(unsigned char)msgid msgData:(NSData *)msgData {
    if(!msgData) {
        return;
    }
    
//    if (msgid != kRequestType_ClientBreak) {
//        DLog(@"Central send type：0x%lx", (long)msgid);
//    }
    
    NSData * sendData = [ForwardHead appenMsgID:msgid msgData:msgData];
    [self send:sendData];
}

/// 发送指令
/// @param msgid 指令类型
/// @param messageObjc 指令数据
- (void)sendMsg:(unsigned char)msgid message:(GPBMessage *)messageObjc {
    if (![messageObjc isKindOfClass:[GPBMessage class]]) {
        DLog(@"Central send fail：0x%lx", (long)msgid);
        return;
    }
    [self sendMsg:msgid msgData:[messageObjc data]];
}

#pragma mark 数据接收
// 收到包进行分发
- (void)receive:(NSData *)root {
    if (root == nil) {
        DLog(@"收到心跳包");
        return ;
    }
    NSMutableData *tmpbuf = [[NSMutableData alloc] init];
    [tmpbuf setLength:0];
    [tmpbuf appendData:root];
    NSData *redata = [tmpbuf subdataWithRange:NSMakeRange(1, tmpbuf.length - 1)];
    
    Byte *testByte = (Byte *)[root bytes];
    
    if (testByte[0] == 0x02) {
     
        RLoginResult *msg = [RLoginResult parseFromData:redata error:nil];
        if (msg.rfdnum) {
            self.ready = 1;
        }
        
    }
    
    
    
    
    // 服务器登录结果
}

/// 计时器事件
- (void)timerAction {
    static NSInteger heartBeatCountdown = 1;
    if (heartBeatCountdown < 10) {
        heartBeatCountdown++;
    } else {
        [self sendHeartBeat];
        heartBeatCountdown = 1;
    }
}

#pragma mark <GCDAsyncSocketDelegate>
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    DLog(@"Central connection success %@:%d", self.ip, self.port);
    self.serviceStatus = kServiceStauts_Connecting;
    
    // 使用SSL连接
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings setObject:@(YES) forKey:GCDAsyncSocketManuallyEvaluateTrust];
    [sock startTLS:settings];//启动SSL连接请求
}

/// 手动认证SSL证书
- (void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
}

/// SSL证书安全，开始登陆中心服务器
- (void)socketDidSecure:(GCDAsyncSocket *)sock {
    dispatch_async(self.socketQueue, ^{
        [self toAuth];
    });
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    DLog(@"Central disconnected:【%@】", err.localizedDescription ?: @"no error");
    [TD_ClientInstance share].isConnectService = NO;
    if (err) {
        _connectFailCount++;
    }
    [self disConnect];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    dispatch_async(self.socketQueue, ^{

        [self->_buffer appendData:data];
        
        while (self->_buffer.length >= 4) {
            SInt32 reclen = 0;
            [self->_buffer getBytes:&reclen length:4];    // 读取长度
            SInt32 length  = htonl(reclen);    //转换
            if (length == 0) {
                if (self->_buffer.length >= 4) {          // 长度够不够心跳包
                    NSData *tmp = [self->_buffer subdataWithRange:NSMakeRange(4, self->_buffer.length - 4)];
                    [self->_buffer setLength:0];      // 清零
                    [self->_buffer appendData:tmp];
                } else {
                    [self->_buffer setLength:0];
                }
                [self receive:nil];    // 分发数据包
            } else {
                NSUInteger packageLength = 4 + length;
                if (packageLength <= self->_buffer.length) {     // 长度判断
                    NSData *rootData = [self->_buffer subdataWithRange:NSMakeRange(4, length)];
                    // 截取
                    NSData *tmp = [self->_buffer subdataWithRange:NSMakeRange(packageLength, self->_buffer.length - packageLength)];
                    [self->_buffer setLength:0];      // 清零
                    [self->_buffer appendData:tmp];
                    [self receive:rootData];    // 分发包
                } else {
                    break;
                }
            }
        }
    });
    [self.socket readDataWithTimeout:TimeOut tag:100];       // 设置下次接收数据的时间, tag
}


#pragma mark 心跳计时器
/// 心跳
- (void)sendHeartBeat {
    if ([TD_ClientInstance share].isConnectService) {
        ClientBreak *lmsg = [ClientBreak message];
        lmsg.id_p = 1;
        [self sendMsg:kCSocketRequest_Break msgData:[lmsg data]];
    }
}

#pragma mark getter
- (BOOL)status {
    if (self.socket != nil && self.socket.isConnected) {
        return true;
    }
    return false;
}

#pragma mark 懒加载
- (dispatch_queue_t)socketQueue {
    if (_socketQueue == nil) {
        _socketQueue = dispatch_queue_create("com.sendSocket", DISPATCH_QUEUE_SERIAL);
    }
    return _socketQueue;
}

- (int)readyStatus{
    
    return self.ready;
    
}

@end
