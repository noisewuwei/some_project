//
//  PaymentController.m
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "PaymentController.h"
#import "PaymentCell.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"
#import "PaySuccessController.h"
#import "DetailController.h"

#define AlipayUrl  @"app_alipay_params"
#define WXPayUrl  @"app_wxpay_parameters"

@interface PaymentController ()<UITableViewDelegate,UITableViewDataSource,WXApiManagerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSArray  *dataArray;
@property (strong, nonatomic) NSIndexPath *selIndex;//单选
@end

@implementation PaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付方式";
    [self buildShowView];
    
    [WXApiManager sharedManager].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultCallHandle:) name:nAlipayNotification object:nil];
}

-(void)buildShowView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSInteger row = [[ZJStoreDefaults getObjectForKey:@"payWay"] integerValue];
    if (row) {
        _selIndex = [NSIndexPath indexPathForRow:row inSection:0];
    }else{
         _selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tableView:self.tableView didSelectRowAtIndexPath:_selIndex];
    });
    
}

#pragma mark -- payment
-(void)readyPayAction:(UIButton*)sender{
   
    [ZJStoreDefaults setObject:[NSString stringWithFormat:@"%ld",(long)_selIndex.row] forKey:@"payWay"];
    if (_selIndex.row == PaymentWayWXPay) {
        NSLog(@"微信支付");
        if (![WXApi isWXAppInstalled]) {
            //检查用户是否安装微信
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有安装微信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上安装", nil];
            alter.tag = 400;
            [alter show];
            return;
        }
        NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
        if (user_id && self.order_no) {
            NSDictionary *paramsDic = @{@"user_id":user_id,@"type":self.isOneSnatch?@"1":@"0",@"order_id":self.order_no};
            
            [self loadDataFromServerWithUrl:WXPayUrl params:paramsDic];
        }

    }else if (_selIndex.row == PaymentWayZhiFuBaoPay){
        NSLog(@"支付宝支付");
        NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
        if (user_id && self.order_no) {
            NSDictionary *paramsDic = @{@"user_id":user_id,@"type":self.isOneSnatch?@"1":@"0",@"order_id":self.order_no};
            
            [self loadDataFromServerWithUrl:AlipayUrl params:paramsDic];
        }
        
    }else{
        NSLog(@"其他支付");
    }
}

#pragma mark -- 支付宝支付
-(void)zhiFuBaoPay:(id)alipay_params{
    if ([alipay_params isKindOfClass:[NSDictionary class]]) {
        NSDictionary *payDict = (NSDictionary*)alipay_params;
        /*
         *商户的唯一的parnter和seller。
         *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
         */
        
        /*============================================================================*/
        /*=======================需要填写商户app申请的===================================*/
        /*============================================================================*/
        NSString *partner = payDict[@"partner"];
        NSString *seller = payDict[@"seller_id"];
        NSString *privateKey = payDict[@"private_key"]?payDict[@"private_key"]:@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALdebBKBbnSoiCsFjUQeap1MhEebK7t8zTshTZ0HOUCiuZm0UtmwYwQBjMgOmyiWenyPXbIvdQH1GNRfcY46SizHy/nKM91ikdrMD9MLi1O1guKO4xhtTZjKaSScEIs250xJHrx0tLTk9SLCVWB7MlrvKZmP3DzM14gG41tgG5+fAgMBAAECgYB4xIRTD9HKnXDJPOfUVGANZ2a7rnP4EHMunXl7kVVgv4uTstLaMrST391zqUMBUVIslVO1VlIuztjijlXAwZ01kZ5RBqUKfrbrncYAsWqsQcfhHT0qr6lOa0i/QoZAThRNapbLsjz+53YP0hWyAW7dtSFv7cDpYxU9VGBwREP/iQJBANpUdgXSiPGSZSlYPCFmTmurRbUmigcH0+EDLqkOL4XMYyuQhsiCaQMwm71XCmJk7+a3dnvDdMjVgcQG+rmfjisCQQDXAb6uFcwzo6C23fXZiR7D7mHoUbizUPv3OnisReO9vxV2VFzk6RthoOXwPmiPMSWp+daMsuXNG1dq2uENa+5dAkBohBg/r0qJQkiVIz0dzAjseAAVuQ5IUVH3nHtgyH6tcWtj9nrfT7aPpVxYpms9MQ67BsZ8dtPYNIU7Xw/1flEjAkBROFqEvr0+AKD0k5KM06yojUO1FDH2ozAbq53sThaDFk0QPzw8SQbL8ZELGTg8Z29372YqDmaa/aofNoHvpQcNAkEAqrxY6AAEQJWw2q8npNTqZJSK6DLtrj/NFROs1KC1cdJ+euR/FitN4Ua50FZai6aZYziXwBTgiDC9eYGw5QNWJQ==";
        /*============================================================================*/
        
        //partner和seller获取失败,提示
        if ([partner length] == 0 ||
            [seller length] == 0 ||
            [privateKey length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"缺少partner或者seller或者私钥。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }

        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order *order = [[Order alloc] init];
        order.partner = partner;
        order.sellerID = seller;
        order.outTradeNO = payDict[@"out_trade_no"]; //订单ID（由商家自行制定）
        order.subject = payDict[@"subject"]; //商品标题
        order.body = payDict[@"body"]; //商品描述
        order.totalFee = [NSString stringWithFormat:@"%.2f",[payDict[@"total_fee"] floatValue]]; //商品价格
        order.notifyURL =  payDict[@"notify_url"]; //回调URL
        //@"mobile.securitypay.pay"
        order.service = payDict[@"service"];
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showURL = @"m.alipay.com";

        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"YouJuKeBuldingMalls";
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        /*
         如果signedString = nil 或 rsa_private read error : private key is NULL
         解决办法如下：
         1）在RSADataSigner.m文件中 搜索代码 [result appendString:@"-----BEGIN PRIVATE KEY-----\n"]; 将其改成 [result appendString:@"-----BEGIN RSA PRIVATE KEY-----\n"];
         2）在RSADataSigner.m文件中 搜索代码 [result appendString:@"\n-----END PRIVATE KEY-----"]; 将其改成 [result appendString:@"\n-----END RSA PRIVATE KEY-----"];
         
         */
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                //非跳转钱包wap支付的回调
                NSLog(@"reslut = %@",resultDic);
            }];
        }

    }else{
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"YouJuKeBuldingMalls";
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:alipay_params fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            //非跳转钱包wap支付的回调
            [[NSNotificationCenter defaultCenter] postNotificationName:nAlipayNotification object:nil userInfo:resultDic];
            
        }];

    }
    
}

#pragma mark -- 通知
-(void)payResultCallHandle:(NSNotification*)notification{
    
    NSDictionary *resultDic = notification.userInfo;
    if ([resultDic[@"resultStatus"] integerValue] == 6001) {
        NSLog(@"用户中途取消");
    }else if ([resultDic[@"resultStatus"] integerValue] == 9000){
        NSLog(@"订单支付成功");
        //统计订单支付成功量
        [[BaiduMobStat defaultStat] logEvent:@"pay_count" eventLabel:@"payType_Alipay"];
        
//        PaySuccessController *paySuccess = [[PaySuccessController alloc] init];
//        [self.navigationController pushViewController:paySuccess animated:YES];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeOrder" object:nil userInfo:nil];
        //目前跳到待发货详情
        DetailController *detail = [[DetailController alloc] init];
        detail.orderId = self.order_no;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if ([resultDic[@"resultStatus"] integerValue] == 4000){
        NSLog(@"订单支付失败");
        NSString *memo = resultDic[@"memo"];
        NSString *message = memo.length>0 ? memo:@"订单支付失败";
        [ZJStaticFunction alertView:self.view msg:message];
    }else if ([resultDic[@"resultStatus"] integerValue] == 5000){
        NSLog(@"重复请求");
        [ZJStaticFunction alertView:self.view msg:resultDic[@"memo"]];
    }else if ([resultDic[@"resultStatus"] integerValue] == 6002){
        NSLog(@"网络连接出错");
        NSString *memo = resultDic[@"memo"];
        NSString *message = memo.length>0 ? memo:@"网络连接出错";
        [ZJStaticFunction alertView:self.view msg:message];
    }else if ([resultDic[@"resultStatus"] integerValue] == 8000){
        NSLog(@"正在处理中，支付结果未知");
    }else if ([resultDic[@"resultStatus"] integerValue] == 6004){
        NSLog(@"支付结果未知");
    }else{
        NSLog(@"支付错误");
        NSString *memo = resultDic[@"memo"];
        NSString *message = memo.length>0 ? memo:@"支付错误";
        [ZJStaticFunction alertView:self.view msg:message];
    }

}

#pragma mark -- 加载数据
- (void)loadDataFromServerWithUrl:(NSString*)url params:(NSDictionary*)param
{
    [self.Hud show:YES];
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        if ([url isEqualToString:WXPayUrl]) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary*)json;
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                //商户号
                req.partnerId           = [dict objectForKey:@"partnerid"];
                //预支付交易会话ID
                req.prepayId            = [dict objectForKey:@"prepayid"];
                //随机字符串，不长于32位
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                NSDateFormatter* formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *timeStamp = [formatter stringFromDate:[NSDate date]];
                //时间戳
                req.timeStamp           = stamp?stamp.intValue:timeStamp.intValue;
                //暂填写固定值Sign=WXPay
                req.package             = [dict objectForKey:@"package"];
                //签名
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }
            
        }else if ([url isEqualToString:AlipayUrl]){
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary*)json;
                if (dic.allKeys.count == 1) {
                    [self zhiFuBaoPay:dic[@"alipay_params"]];
                }else{
                    [self zhiFuBaoPay:json];
                }
                
            }
            
            /*
             "_input_charset" = "utf-8";
             body = "\U4f18\U5c45\U5ba2\U8ba2\U5355";
             "notify_url" = "http://prebk.youjuke.com/alipay/notify";
             "out_trade_no" = 160928114757693537;
             partner = 2088311671246133;
             "payment_type" = 1;
             "return_url" = "http://prebk.youjuke.com/alipay/return_notify";
             "seller_id" = 2088311671246133;
             service = "mobile.securitypay.pay";
             sign = "S0se4T0lCA3hRVtF7aqssvCFKz7+uQAY5uqb6FDDOw0KhXWbdur07dKgBsXu68lv985aDefVza+BwisGXIn0p1lAncypazH5SWmH8VLeT3+BHqZmp7VEO3hKHQb97Si8HE28b/PtN11FL0sywONjxyiD47Bb3sa2MlB/Kd1LpLs=";
             "sign_type" = RSA;
             subject = "\U4f18\U5c45\U5ba2\U8ba2\U5355";
             "total_fee" = "0.01";
             */

        }
        
    } error400Code:^(id failure) {
        
    }];
}


#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)req {
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@", req.openID];
    
    NSLog(@"%@ == %@",strMsg,strTitle);
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", req.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt];
    NSLog(@"%@ == %@",strMsg,strTitle);
   
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //从微信启动App
    NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", req.openID, msg.messageExt];
    NSLog(@"%@ == %@",strMsg,strTitle);
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", response.errCode];
    
  NSLog(@"%@ == %@",strMsg,strTitle);
}

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response {
    NSMutableString* cardStr = [[NSMutableString alloc] init];
    for (WXCardItem* cardItem in response.cardAry) {
        [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%u\n",cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
    }
   NSLog(@"%@",cardStr);
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
   NSLog(@"%@ == %@",strMsg,strTitle);
}


#pragma mark --UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    header.textLabel.font = [UIFont systemFontOfSize:15];
    header.textLabel.text = @"请选择支付方式";
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] init];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(20, 50, zScreenWidth - 40, 40);
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    payBtn.backgroundColor = [UIColor orangeColor];
    [payBtn addTarget:self action:@selector(readyPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:payBtn];
    
    return footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentModel *model = self.dataArray[indexPath.row];
    PaymentCell *cell = [PaymentCell shareCellWithTable:tableView model:model];
    if (indexPath == _selIndex) {
        cell.selectBtn.selected = YES;
    }else{
        cell.selectBtn.selected = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PaymentCell *oldCell = [tableView cellForRowAtIndexPath:_selIndex];
    oldCell.selectBtn.selected = NO;
    
    _selIndex = indexPath;
    
    PaymentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected = YES;
    
}

#pragma mark --UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark -- getter
-(NSArray*)dataArray{
    if (!_dataArray) {
        NSArray *array = @[@{@"imagName":@"btn_weixin.png",@"titleText":@"微信支付"},
              @{@"imagName":@"btn_zfb",@"titleText":@"支付宝支付"}];
        
        _dataArray = [PaymentModel objectArrayWithKeyValuesArray:array];
    }
    
    return _dataArray;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nAlipayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nWXPayNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
