//
//  Define.h
//  BuldingMall
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import "UIColor+HexString.h"

//定义打印 方法名字，行数，和数据
//ZJLog无论什么环境都打印，NSLog只在DEBUG模式下打印
#define ZJLog(str) NSLog(@"FUNCTION NAME:%s, LINE:%d \n \n NSLog===========================%@", __FUNCTION__, __LINE__,str)
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//系统统一颜色
#define MainColor       [UIColor colorHexString:@"3f3f3c"]
#define BtnColor       [UIColor colorHexString:@"f2de76"]
#define txtColor       [UIColor colorHexString:@"d1e3db"]
//f2de76

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

#define TScreenWidth ([[UIScreen mainScreen] bounds].size.width-60)/3

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



#endif /* Define_h */
