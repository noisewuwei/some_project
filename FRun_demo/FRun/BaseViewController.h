//
//  BaseViewController.h
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//设置右边导航按钮字体和颜色
-(void)createRightTitle:(NSString *)title  titleColor:(UIColor*)titleColor;
//设置右边导航按钮图片
-(void)createBarRightWithImage:(NSString *)imageName;

//布局左边 设置返回图片
-(void)createBarLeftWithImage:(NSString *)imageName;

-(void)showRight:(UIButton *)sender;
-(void)showLeft:(UIButton *)sender;

@end
