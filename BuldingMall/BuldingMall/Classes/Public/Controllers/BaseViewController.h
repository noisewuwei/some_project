//
//  BaseViewController.h
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
typedef void(^ShareBlock)(SSDKResponseState state);

@interface BaseViewController : UIViewController

@property(nonatomic,strong)UITableView  *tableView;
@property(nonatomic,strong)UIWebView    *webView;
@property(nonatomic,strong)MBProgressHUD *Hud;

/*
 分享：
 params 分享参数
 shareBlock 分享结果回调
 */
-(void)shareDarams:(id)params completion:(ShareBlock)shareBlock;

//设置右边导航按钮字体和颜色
-(void)createRightTitle:(NSString *)title  titleColor:(UIColor*)titleColor;
//设置右边导航按钮图片
-(void)createBarRightWithImage:(NSString *)imageName;

//布局左边 设置返回图片
-(void)createBarLeftWithImage:(NSString *)imageName;

-(void)showRight:(UIButton *)sender;
-(void)showLeft:(UIButton *)sender;
@end
