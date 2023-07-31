//
//  LonginController.h
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();
@interface LonginController : BaseViewController<UITextFieldDelegate>

/*
 返回值为NO 弹出登录界面
 参数1.weakSelf传当前视图所在的控制器
 参数2.回调执行

 */
+(BOOL)isLongin:(UIViewController*)weakSelf completion:(CallBlock)callBlock;
//判断是否登录
+(BOOL)shouldLongin;

@end
