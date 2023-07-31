//
//  Define.h
//  BuldingMall
//
//  Created by Jion on 16/9/5.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#ifndef Define_h
#define Define_h

//定义打印 方法名字，行数，和数据
//ZJLog无论什么环境都打印，NSLog只在DEBUG模式下打印
#define ZJLog(str) NSLog(@"FUNCTION NAME:%s, LINE:%d \n \n NSLog===========================%@", __FUNCTION__, __LINE__,str)
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//系统统一颜色
#define GlobalColor       [UIColor colorWithRed:0/255.0 green:194/255.0 blue:79/255.0 alpha:1.0]
#define kGlobalColor      [UIColor colorHexString:@"#00c24f"]

//判断设备
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPOD    ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define IS_Simulator   TARGET_IPHONE_SIMULATOR
//判断机型
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)

#define iPhone6 ([UIScreen mainScreen].bounds.size.width == 375)
#define iPhone6P ([UIScreen mainScreen].bounds.size.width == 414)

//尺寸
#define zScreenHeight [[UIScreen mainScreen] bounds].size.height

#define zScreenWidth [[UIScreen mainScreen] bounds].size.width

#define zNavigationHeight  64

#define zToolBarHeight  49
//系统版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)

//常用字符
#define LoginSucess    @"loginSucess"
#define SDKPlatformType @"SDKPlatformType"

#define kServerError      @"网络加载出错了！😂😂😂"

#define kDataKey        @"data"

//通知名称
#define nAlipayNotification      @"AlipayResultNotification"
#define nWXPayNotification       @"WXPayResultNotification"

#pragma mark ========================
//第三方注册账户key
#define ShareSDK_AppKey      @"17b6f5f35bb6c"
#define ShareSDK_AppSecret   @"ec24a42ea7681dd9e4e6471fa5f10f5f"

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxde06caa10050b707"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"0d0737b13024e8ef4c36cc48038d6f3e"
// 微信支付商户号
#define WXMCH_ID  @"1240673002"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @""

//新浪微博
#define Sina_AppKey     @"786734726"
#define Sina_AppSecret  @"786c8f0ea210a924c235722e2b02ff17"
//腾讯
#define Tencent_APPID    @"1105667159"
#define Tencent_APPKEY   @"RlaukrOSwzZqTYCY"

//百度移动统计
#define BaiduMob_APP_KEY @"c1ef4eaa4a"

#endif /* Define_h */
