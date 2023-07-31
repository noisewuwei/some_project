//
//  PicViewViewController.m
//  FRun
//
//  Created by noise on 2016/11/15.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "PicViewViewController.h"
#import "Define.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@interface PicViewViewController (){
    NSString *Path;
}

@end

@implementation PicViewViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"查看轨迹";
    [self createBarLeftWithImage:@"Back.png"];
    [self createRightTitle:@"分享" titleColor:BtnColor];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, zScreenWidth, zScreenHeight-64)];
    [self.view addSubview:imgv];
    
    Path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),_imgUrl];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:Path];
    
    imgv.image = imgFromUrl;
    
    // Do any additional setup after loading the view.
}

-(void)showRight:(UIButton *)sender{
    NSArray* imageArray = @[[[UIImage alloc]initWithContentsOfFile:Path]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"Show time!"
                                         images:imageArray
                                            url:nil
                                          title:@"酷炫！！！"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        
        // 设置分享菜单的背景颜色
        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor clearColor]];
        // 设置分享菜单颜色
        [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorHexString:@"f5f5dc"]];
        // 设置分享菜单－取消按钮背景颜色
        [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorHexString:@"f5f5dc"]];
        // 设置分享菜单－取消按钮的文本颜色
        [SSUIShareActionSheetStyle setCancelButtonLabelColor:MainColor];
        // 设置分享菜单－社交平台文本颜色
        [SSUIShareActionSheetStyle setItemNameColor:MainColor];
        
        //设置简单分享菜单样式
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSystem];
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
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
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
