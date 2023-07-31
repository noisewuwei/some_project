//
//  TD_CentralServer.h
//  ToDesk_Service
//
//  Created by 海南有趣 on 2020/11/2.
//  Copyright © 2020 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

/// 服务器状态
typedef NS_ENUM(NSInteger, kServiceStauts) {
    kServiceStauts_Normal,
    kServiceStauts_Connecting,
    kServiceStauts_Connected,
    kServiceStauts_Disconnected,
};

/// 中央服务器
@interface TD_RecordServer : NSObject

+ (instancetype)share;

// 网络联通性
@property (assign, nonatomic) BOOL networkStatus;

/// 连接过App（App启动后，连接成功会设置为YES）
@property (assign, nonatomic) BOOL alreadyConnectApp;

/// 服务器状态
@property (assign, nonatomic, readonly) kServiceStauts   serviceStatus;

/// 登录中心服务器，
- (void)connectRecordSever;

/// 断开连接
- (void)disConnect;

/// 发送指令
/// @param msgid 指令类型
/// @param messageObjc 指令数据
- (void)sendMsg:(unsigned char)msgid message:(GPBMessage *)messageObjc;

////向中心服务器备案p2p已经连接
- (void)SendP2PConnectMsg:(bool)isOK hostid:(NSString *)hostID deskid:(NSString *)deskID;

- (int)readyStatus;

@end

NS_ASSUME_NONNULL_END
