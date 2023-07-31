//
//  BaseViewController.m
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import "ShareDataModel.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark -- 用于分享
-(void)shareDarams:(id)params completion:(ShareBlock)shareBlock{
    ShareDataModel *modelShare = (ShareDataModel*)params;
    //1、创建分享参数
    // （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSArray* imageArray;
    if (modelShare.share_image && [modelShare.share_image rangeOfString:@"http"].location == !NSNotFound) {
        imageArray = @[modelShare.share_image];
    }else{
       imageArray = @[[UIImage imageNamed:@"180x180.png"]];
    }
    
    NSString *content = modelShare.share_desc?modelShare.share_desc:@"分享内容:😄想装修快来优居客啊！";
    NSString *title = modelShare.share_title;
    NSString *shareUrl = modelShare.share_link?modelShare.share_link:kHomeWebUrl;
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray
                                            url:[NSURL URLWithString:shareUrl]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        //参数items为nil时，则显示已集成的平台列表。但是微信qq在真机安装有客户端时才显示。
        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:nil
                                                                         items:@[@(SSDKPlatformSubTypeWechatSession),
                                                                                 @(SSDKPlatformSubTypeWechatTimeline),
                                                                                 @(SSDKPlatformSubTypeQQFriend),
                                                                                 @(SSDKPlatformSubTypeQZone),]
                                                                   shareParams:shareParams
                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                               
                                                               if (shareBlock) {
                                                                   shareBlock(state);
                                                               }
                                                        }
                                                 ];
        //跳过新浪微博分享的编辑界面
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
    
}

#pragma mark -- setter
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _tableView;
}

-(UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    
    return _webView;
}
-(MBProgressHUD*)Hud{
    if (!_Hud) {
        UIWindow *keyWin = [[UIApplication sharedApplication] keyWindow];
        _Hud = [[MBProgressHUD alloc] initWithWindow:keyWin];
        _Hud.mode = MBProgressHUDModeIndeterminate;
        _Hud.removeFromSuperViewOnHide = YES;
        
    }
    [self.view addSubview:_Hud];
    return _Hud;
}
//布局左边 设置返回图片
-(void)createBarLeftWithImage:(NSString *)imageName{
    
    if (imageName==nil) {
        return;
    }
    
    if ([imageName length]==0) {
        return;
    }
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
   
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnb sizeToFit];
    
    // btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;
    
}

-(void)showLeft:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


//设置右边导航按钮字体和颜色
-(void)createRightTitle:(NSString *)title  titleColor:(UIColor*)titleColor{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    if (title.length>3) {
        btnb.frame = CGRectMake (0, 0, 80, 44);
    }
    else
    {
        btnb.frame = CGRectMake (0, 0, 44, 44);
        
    }
    btnb.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    
    [btnb setTitle:title forState:UIControlStateNormal];
    [btnb setTitleColor:titleColor forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btnb.titleLabel.textAlignment = NSTextAlignmentRight;
    [btnb addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.rightBarButtonItem = ubar;
    
}
//设置右边导航按钮图片
-(void)createBarRightWithImage:(NSString *)imageName{
    if (imageName==nil) {
        
        return;
    }
    
    if ([imageName length]==0) {
        return;
    }
    
    UIButton *remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 24)];
    //    [_remindBtn setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [remindBtn setImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [remindBtn addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :remindBtn];
    self.navigationItem.rightBarButtonItem = ubar;
    
}


-(void)showRight:(UIButton *)sender{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
