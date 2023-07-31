//
//  ZJTabBarController.m
//  BuldingMall
//
//  Created by Jion on 16/9/5.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ZJTabBarController.h"
#import "ZJNavigationController.h"
#import "LonginController.h"
#import "ZLCGuidePageView.h"
#import "OderListController.h"
#import "HomeViewController.h"
#import "MyController.h"



@interface ZJTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong)UIButton *button;
@end

@implementation ZJTabBarController
@synthesize button;
#pragma mark- setup
-(void)setup
{
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"btndbtq1.png"] selectedImage:[UIImage imageNamed:@"btndbtq2.png"]];
    //  UITabBarControllerDelegate 指定为自己
    self.delegate=self;
    //  指定当前页——中间页
    self.selectedIndex=0;
    //  设点button状态
    //button.selected=YES;
    //  设定其他item点击选中颜色
    
}
#pragma mark - addCenterButton
// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    button.frame = CGRectMake(zScreenWidth/2-buttonImage.size.width/2,-14, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    button.adjustsImageWhenHighlighted=NO;
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
//    CGPoint center = self.tabBar.center;
//    center.y = center.y - buttonImage.size.height/4-3;
//    button.center = center;
    [self.tabBar addSubview:button];
}

-(void)pressChange:(id)sender
{
    BOOL longin = [LonginController isLongin:self completion:^{
        self.selectedIndex=1;
        button.selected=YES;
    }];
    if (longin) {
        self.selectedIndex=1;
        button.selected=YES;
    }
 
}

#pragma mark- TabBar Delegate

//  换页和button的状态关联上

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex==1) {
        button.selected=YES;
    }else
    {
        button.selected=NO;
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];
    if (index == 2 || index == 1) {
    
      BOOL longin = [LonginController isLongin:self completion:^{
          self.selectedIndex = index;
          if (index == 1) {
              button.selected=YES;
          }
          
      }];
        return longin;
    }

    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    self.delegate = self;

    // noise coding guide page view

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){

        [self setTabBarVC];
        [self setup];
        self.tabBar.backgroundImage = [UIImage imageNamed:@"ssg.png"];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

        NSArray *images =  @[[UIImage imageNamed:@"PA1.png"],[UIImage imageNamed:@"PA2.png"],[UIImage imageNamed:@"PA3.png"]];

        // create guide page view

        ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.view.frame WithImages:images];
        [self.view addSubview:pageView];


    }else{

        [self setTabBarVC];
        [self setup];
        self.tabBar.backgroundImage = [UIImage imageNamed:@"ssg.png"];
    }


}


// 初始化所有子控制器
- (void)setTabBarVC{
    [self setTabBarChildController:[[HomeViewController alloc] init] title:@"首页" image:@"首页未选中.png" selectImage:@"首页已经选中.png"];
    
    [self setTabBarChildController:[[OderListController alloc] init] title:@"订单跟踪" image:@"" selectImage:@""];
    
    [self setTabBarChildController:[[MyController alloc] init] title:@"我的" image:@"我的-未选中.png" selectImage:@"我的-已选中.png"];
}


// 添加tabbar的子viewcontroller
- (void)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    ZJNavigationController* nav = [[ZJNavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem.title = title;
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [nav.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSShadow *shad = [[NSShadow alloc] init];
    shad.shadowColor = [UIColor whiteColor];
    NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:kGlobalColor,NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [nav.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//@end
//
//@implementation ZJTabBarController
//
//#pragma mark - addCenterButton
//// Create a custom UIButton and add it to the center of our tab bar
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//     self.view.backgroundColor = [UIColor whiteColor];
//    // Do any additional setup after loading the view.
//    
//    self.delegate = self;
//    
//    // noise coding guide page view
//    
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        
//        [self newTabBarView];
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        
//        NSArray *images =  @[[UIImage imageNamed:@"page1.png"],[UIImage imageNamed:@"page2.png"],[UIImage imageNamed:@"page3.png"]];
//        
//        // create guide page view
//        
//        ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.view.frame WithImages:images];
//        [self.view addSubview:pageView];
//        
//        
//    }else{
//        
//        [self newTabBarView];
//    }
//    
//    
//}
//
////10月11号启动页 version 判断
//+(BOOL)isshowserguideload
//{
//    //获取当前的版本
//    NSString *longBuildVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//    NSLog(@"shortVersion%@",longBuildVersion);
//    
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    
////    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
////    
////    if (!lastRunVersion) {
////        
////        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
////        
////        return YES;
////        
////    }else if (![lastRunVersion isEqualToString:currentVersion]) {
////        
////        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
////        
////        return YES;
////        
////    }
//    
//    
////    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
////    
////    NSArray *infoArray = [dict objectForKey:@"results"];
////    if ([infoArray count])
////    {
////        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
////        NSString *latestVersion = [releaseInfo objectForKey:@"version"];
////    }
//    
//    return NO;
//    
//
//}
//- (void)newTabBarView{
//    
//    
//    
//    
//    
////    NSArray *titleArray = @[@"首页",@"现场特卖",@"微信关注",@"我的"];
////    NSArray *imageArray = @[@"首页未选中.png",@"现场特卖未选中.png",@"微信关注未选中.png",@"我的-未选中.png"];
////    NSArray *imageSelectArray =@[@"首页已经选中.png",@"现场特卖已经选中.png",@"微信关注已选中.png",@"我的-已选中.png"];
////    //添加子控制器
////    NSArray *classNames = @[@"HomeViewController",@"OnSaleController", @"WXFollowController", @"MyController"];
//    NSArray *titleArray = @[@"首页",@"订单跟踪",@"我的"];
//    NSArray *imageArray = @[@"首页未选中.png",@"btn_ddgz1.png",@"我的-未选中.png"];
//    NSArray *imageSelectArray =@[@"首页已经选中.png",@"btn_ddgz2.png",@"我的-已选中.png"];
//    //添加子控制器
//    NSArray *classNames = @[@"HomeViewController",@"OderListController", @"MyController"];
//    
//    
//    for (int j=0;j<classNames.count;j++) {
//        NSString *className = classNames[j];
//        UIViewController *vc = [(UIViewController*)[NSClassFromString(className) alloc] init];
//        
//        vc.tabBarItem.image = [[UIImage imageNamed:imageArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        
//        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelectArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        vc.tabBarItem.title = titleArray[j];
//        
//        //设置tabbar的title的颜色，字体大小，阴影
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
//        [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
//        
//        NSShadow *shad = [[NSShadow alloc] init];
//        shad.shadowColor = [UIColor whiteColor];
//        NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:kGlobalColor,NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
//        [vc.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
//        ZJNavigationController *navi = [[ZJNavigationController alloc] initWithRootViewController:vc];
//        
//        [self addChildViewController:navi];
//    }
//    
//    
//}



@end
