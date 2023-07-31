//
//  ProductDetailController.m
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ProductDetailController.h"
#import "CustomerServiceVC.h"
#import "ConfirmOrderController.h"
#import "OneSnatchController.h"
#import "PickerSheetView.h"
#import "WarnView.h"
#import "GoodsModel.h"
#import "ShareDataModel.h"
#import "UpdateAddressController.h"
#import "ZJTabBarController.h"
#import "ShareChanceAlertView.h"

@interface ProductDetailController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary *_directBuyDic;
}
@property(nonatomic,strong)NSArray  *dataArray;
@property(nonatomic,strong)GoodsModel *goodsModel;
@property(nonatomic,strong)ShareDataModel *shareDataModel;
@property(nonatomic,strong)NSString  *goods_id;
@property(nonatomic,strong)JSContext *jsContext;
@end

@implementation ProductDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary *dict = [NSMutableDictionary dictionary];
    //type 0 当前秒杀商品 1 非当前秒杀商品 2 一元换购商品
    if ([self.webPath isEqualToString:@"/onsale/item"]) {
        [dict setValue:@"0" forKey:@"type"];
        self.title = @"今日秒杀";
    } else if([self.webPath isEqualToString:@"/redemption/detail"]) {
        [dict setValue:@"2" forKey:@"type"];
    }
    else{
        [dict setValue:@"1" forKey:@"type"];
    }
    
    if (self.goods_id) {
        [dict setValue:self.goods_id forKey:@"id"];
    }
    
    [self loadDataFromServer:@"SeckillData" ProgressHUD:self.Hud params:dict];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详细";
    [self createRightTitle:@"分享" titleColor:[UIColor whiteColor]];
    
    if ([self.webRequestURL rangeOfString:@"?"].location != NSNotFound) {

        if ([self.webRequestURL rangeOfString:@"platform"].location == NSNotFound){
            self.webRequestURL = [self.webRequestURL stringByAppendingString:@"&platform=app"];
        }
        
        NSDictionary *dict = [ZJStaticFunction jsonGetUrlParam:self.webRequestURL];
        if (dict[@"id"]) {
            self.goods_id = dict[@"id"];
        }
        
    }else{
        self.webRequestURL = [self.webRequestURL stringByAppendingString:@"?platform=app"];
    }
    
    [self buildView];
    
    NSDictionary *dict = [NSMutableDictionary dictionary];
    //type 0 未知 1 精选特卖商品 2 一元换购商品 3 当前秒杀商品
    if ([self.webPath isEqualToString:@"/onsale/old_item"]) {
        [dict setValue:@"1" forKey:@"type"];
        
    } else if([self.webPath isEqualToString:@"/redemption/detail"]) {
        [dict setValue:@"2" forKey:@"type"];
    }
    else if([self.webPath isEqualToString:@"/onsale/item"]) {
        [dict setValue:@"3" forKey:@"type"];
    }
    else{
        [dict setValue:@"0" forKey:@"type"];
    }
    
    if (self.goods_id) {
        [dict setValue:self.goods_id forKey:@"gid"];
    }
    NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
    if (user_id && user_id.length > 0) {
        [dict setValue:user_id forKey:@"uid"];
    }
    [self loadDataFromServer:@"GetShareData" ProgressHUD:nil params:dict];
}

#pragma mark -- 加载数据
-(void)loadDataFromServer:(NSString*)url ProgressHUD:(MBProgressHUD*)HUD params:(NSDictionary*)param{
    [HTTPRequest postWithURL:url params:param ProgressHUD:HUD controller:nil response:^(id json) {
        //获取商品数据
        if ([url isEqualToString:@"SeckillData"]) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                
                _goodsModel = [GoodsModel objectWithKeyValues:json];
                
            }
            
        }else if ([url isEqualToString:@"GetShareData"]){
            //获取分享数据接口
            _shareDataModel = [ShareDataModel objectWithKeyValues:json];
        }
        else if([url isEqualToString:@"save_order"]){
            //生成订单接口
            if ([json isKindOfClass:[NSDictionary class]]) {
                //如果生成订单成功，发通知刷新个人中心数据
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOrder" object:nil userInfo:nil];
                //统计生成订单量
                [[BaiduMobStat defaultStat] logEvent:@"create_order" eventLabel:@"save_order"];
                
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
                BuildOrderModel *newOrderModel = [BuildOrderModel objectWithKeyValues:dic];
                //生成订单界面
                ConfirmOrderController *confirmOrder = [[ConfirmOrderController alloc] init];
                confirmOrder.buildOrderModel = newOrderModel;
                [self.navigationController pushViewController:confirmOrder animated:YES];
            }
            
        }else if ([url isEqualToString:@"one_grap_treasure"]){
            //一元夺宝接口
            OneSnatchController *oneSnatch = [[OneSnatchController alloc] init];
            
            [self.navigationController pushViewController:oneSnatch animated:YES];
        }
        
    } error400Code:^(id failure) {
        [self error400CodeUrl:url callCode:failure];
   }];

}

-(void)error400CodeUrl:(NSString*)url callCode:(NSDictionary*)failure{
    if ([url isEqualToString:@"save_order"]) {
        if ([failure[@"error"] integerValue] == 4000 || [failure[@"message"] rangeOfString:@"地址"].location != NSNotFound) {
            if ([failure[@"message"] isKindOfClass:[NSString class]]) {
                [ZJStaticFunction alertView:self.view msg:failure[@"message"]];
            }
            
            [self performSelector:@selector(delayTimeAction) withObject:nil afterDelay:2.0];
        }else if ([failure[@"error"] isEqualToString:@"save_order_4007"] ||[failure[@"error"] isEqualToString:@"save_order_4008"] || [failure[@"error"] isEqualToString:@"save_order_4009"]){
            
            ChanceType chanceType = [failure[@"error"] isEqualToString:@"save_order_4007"]?ChanceTypeDefault:ChanceTypeNone;
            
            [ShareChanceAlertView instanceCustomAlert:chanceType handle:^(EventType eventType) {
                if (eventType == EventTypeShare) {
                    //立即分享
                    [self shareConentResult];
                }else if (eventType == EventTypeGoBuy){
                    //全款购买
                    if (_directBuyDic) {
                        [_directBuyDic removeObjectForKey:@"redemption_id"];
                        [self loadDataFromServer:@"save_order" ProgressHUD:self.Hud params:_directBuyDic];
                    }
                }else if (eventType == EventTypeGoBack){
                    //返回首页
                    for (UIViewController *vc in self.navigationController.childViewControllers) {
                        if ([vc isKindOfClass:NSClassFromString(@"HomeViewController")]) {
                            [self.navigationController popToViewController:vc animated:YES];
                            return ;
                        }
                    }
                    
                }
            }];
        }else {
            
            [ZJStaticFunction alertView:self.view msg:failure[@"message"]];
        }
    }else{
        [ZJStaticFunction alertView:self.view msg:failure[@"message"]];
    }

}

#pragma mark -- 延迟
-(void)delayTimeAction{
    UpdateAddressController *newAddress = [[UpdateAddressController alloc] init];
    newAddress.title = @"添加收货地址";
    [self.navigationController pushViewController:newAddress animated:YES];
}

-(void)buildView{
    self.webView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight);
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.Hud show:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webRequestURL]]];
    
    //初始化javascript运行环境
    JSContext *jsctx = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak typeof(self) weakSelf = self;
    jsctx[@"tags"] = weakSelf;
    
    _toolBar = [[BuyBottomView alloc] initWithFrame:CGRectMake(0, zScreenHeight - 45 - zNavigationHeight, zScreenWidth, 45) eventAction:^(ActionStyle index) {
        NSLog(@"index == %lu",(unsigned long)index);
        [self showInView:index];
        
        }];
    if ([self.webPath isEqualToString:@"/onsale/item"]) {
        //10元预抢和全款秒杀
        _toolBar.panicBuyingType = @0;
    }else if ([self.webPath isEqualToString:@"/onsale/old_item"]){
        //普通购买 即精选特卖商品
        _toolBar.panicBuyingType = @1;
    }else if ([self.webPath isEqualToString:@"/snatch/snatch_item"]){
        //一元夺宝和全款购买
        _toolBar.panicBuyingType = @2;
    }else if ([self.webPath isEqualToString:@"/redemption/detail"]){
        //一元换购
        _toolBar.panicBuyingType = @3;
    }
    
    
    [self.view addSubview:_toolBar];
}

#pragma mark htmlXY
- (void)showIndex:(NSInteger )num;
{
    NSLog(@"=======%ld",num);
    if (num == 0) {
        //10元预抢和全款秒杀
        _toolBar.panicBuyingType = @0;
    }else{
        //即将开始
        _toolBar.panicBuyingType = @4;
    }
    
}

-(void)showInView:(ActionStyle)index{
    if (index == ActionStyleService) {

        CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
        NSString *serviceUrl = @"http://m.youjuke.com/index/kf_html";
        customerService.webPath = @"/im/gateway";
        customerService.webRequestURL = serviceUrl;
        
        [self.navigationController pushViewController:customerService animated:YES];
        
    }else if (index == ActionStylePhone){
        //客服电话
        NSMutableString *str = [NSMutableString stringWithString:@"4006891616"];
        if (str.length >=8)
        {
            [str insertString:@"-" atIndex:3];
            [str insertString:@"-" atIndex:8];
            
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alertView show];

        
    }else if (index == ActionStyleFullPayment){
        __weak typeof(self) weakSelf = self;
        PickerSheetView *sheetView = [PickerSheetView instancePickerSheetView:self commitBlock:^(id model) {
            
            [weakSelf loadDataFromServer:@"save_order" ProgressHUD:self.Hud params:model];
            
        }];
        //设置sheetType类型
        if ([self.webPath isEqualToString:@"/onsale/item"]) {
            //全款秒杀，
            sheetView.sheetType = SheetTypeMerit;
            
        }
        else{
            //全款购买
            sheetView.sheetType = SheetTypeDefault;
        }
        
        sheetView.goodsModel = _goodsModel;
        
    }
    else if (index == ActionStylePrepare){
        //10元预抢
        [WarnView sharePickerSheetView:^{
            PickerSheetView *sheetView = [PickerSheetView instancePickerSheetView:self commitBlock:^(id model) {
                //发起订单请求
                [self loadDataFromServer:@"save_order" ProgressHUD:self.Hud params:model];
            }];
            sheetView.sheetType = SheetTypePrepare;
            sheetView.goodsModel = _goodsModel;
        }];
        
    }else if (index == ActionStylePayment1){
        //一元抢购
        __weak typeof(self) weakSelf = self;
        PickerSheetView *sheetView = [PickerSheetView instancePickerSheetView:self commitBlock:^(id model) {
            _directBuyDic = [NSMutableDictionary dictionaryWithDictionary:model];
            [weakSelf loadDataFromServer:@"save_order" ProgressHUD:self.Hud params:model];
            
        }];
        sheetView.sheetType = SheetTypePayment1;
        sheetView.goodsModel = _goodsModel;

    }
    else if (index == ActionStyleSnatch1){
        //一元夺宝
        PickerSheetView *sheetView = [PickerSheetView instancePickerSheetView:self commitBlock:^(id model) {
            OneSnatchController *oneSnatch = [[OneSnatchController alloc] init];
            
            [self.navigationController pushViewController:oneSnatch animated:YES];
//            [weakSelf loadDataFromServer:@"one_grap_treasure" params:model];
        }];
        sheetView.sheetType = SheetTypeSnatch1;
        sheetView.goodsModel = _goodsModel;
    }


    else{
        [ZJStaticFunction alertView:self.view msg:@"别急，还没开始"];
    }

}

#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *path = request.URL.path;
    NSString * requestStr =[request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *body  =[[ NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    //立即抢购：member/qrorderitem 参数body：reference_url=%2Fonsale%2Fitem&classification%5B%5D=31&num%5B31%5D=1
    //登录后url：http://m.youjuke.com/member/qrorderitem?classification={"reference_url":"\/onsale\/item","classification":["31"],"num":{"31":"1"}}
    
    //立即支付：member/pay 参数：order_id=3107
    //客服path：/im/gateway
    //客服url:http://webim.qiao.baidu.com/im/gateway?ucid=7157574&type=z&siteid=9298520
    //在线留言path:/cps/chat
    //在线留言：http://p.qiao.baidu.com/cps/chat?siteId=9806126&userId=7157574
    
    //服务协议：/onsale/fuwu
    
    if ([path isEqualToString:@"member/qrorderitem"]) {
        ConfirmOrderController *confirmOrder = [[ConfirmOrderController alloc] init];
        
        [self.navigationController pushViewController:confirmOrder animated:YES];
        return NO;
    }else if ([path isEqualToString:@"/im/gateway"]||[path isEqualToString:@"/onsale/fuwu"]){
        CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
        customerService.webPath = path;
        customerService.webRequestURL = requestStr;
        
        [self.navigationController pushViewController:customerService animated:YES];
        
        return NO;
    }else if ([path isEqualToString:@"/onsale/old_item"] && !self.goods_id){
        //往期秒杀
        ProductDetailController *productDetail = [[ProductDetailController alloc] init];
        productDetail.webPath = path;
        productDetail.webRequestURL = requestStr;
        if (body) {
            productDetail.params = body;
        }
        [self.navigationController pushViewController:productDetail animated:YES];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.Hud hide:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.Hud hide:YES];
}

#pragma mark--UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 55) {
        if (buttonIndex == 1){
            [self shareConentResult];
        }
        
    }else{
        if (buttonIndex == 1){
            NSString *moble = [alertView.message stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",moble]]];
            
        }

    }
    
}

#pragma mark -- 分享操作
-(void)showRight:(UIButton *)sender{
   
    if ([self.webPath isEqualToString:@"/redemption/detail"] && ![LonginController shouldLongin]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@" 亲，登录后分享能获得多次换购机会哦！您未登录，确定直接分享吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 55;
        [alertView show];
        
    }else{
        [self shareConentResult];
    }
}

-(void)shareConentResult{
    
    [self shareDarams:_shareDataModel completion:^(SSDKResponseState state) {
        [[BaiduMobStat defaultStat] logEvent:@"share_count" eventLabel:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                [ZJStaticFunction alertView:self.view msg:@"分享失败"];
                break;
            }
            case SSDKResponseStateCancel:
            {
                NSLog(@"分享已取消");
                break;
            }
            default:
                break;
        }
        
    }];
 
}

-(NSDictionary*)simulationDic{
    
     NSDictionary *dic = @{@"goods_id":@"36",@"goods_image":@"/origin/20160907/normal14732127654049.jpg",@"classifications":@[@{@"classifications_id":@"55",@"name":@"商品1+抢购商品8",@"num":@"4",@"seckill_price":@"0.50",@"subsidy":@"10.00"},@{@"classifications_id":@"56",@"name":@"商品1+商品2",@"num":@"0",@"seckill_price":@"50.00",@"subsidy":@"100.00"},@{@"classifications_id":@"57",@"name":@"商品1+商品2+商品3",@"num":@"10",@"seckill_price":@"88.88",@"subsidy":@"199.00"}]};
    
    return dic;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
