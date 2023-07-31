//
//  PerViewController.m
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "PerViewController.h"
#import "Define.h"
#import "ZJStaticFunction.h"
#import "GuijiViewController.h"
#import "ZJStoreDefaults.h"

@interface PerViewController (){
    UILabel *totalnum;
    UILabel *todaynum;
}

@end

@implementation PerViewController

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
    id todis = [ZJStoreDefaults getObjectForKey:@"todaydistance"];
    id totaldis = [ZJStoreDefaults getObjectForKey:@"totaldistance"];
    NSString *todistance = todis;
    NSString *totaldistance = totaldis;
    NSString *todayDis = [NSString stringWithFormat:@"%.f",[todistance doubleValue]];
    NSString *totalDis = [NSString stringWithFormat:@"%.2f",[totaldistance doubleValue]];
    
    
    self.follower.delegate = self;
    
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"个人域";
    [self createBarLeftWithImage:@"Back.png"];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-40, 74, 80, 80)];
    headImg.image = [ZJStaticFunction changeimagetocilce:[UIImage imageNamed:@"head.png"]];
    [self.view addSubview:headImg];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(15, 74+80+20, zScreenWidth-30, 98)];
    backview.layer.cornerRadius = 8;
    backview.backgroundColor = txtColor;
    [self.view addSubview:backview];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/2-15-0.5, 10, 1, 78)];
    lineview.backgroundColor = MainColor;
    [backview addSubview:lineview];
    
    UILabel *today = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, zScreenWidth/2-25, 15)];
    today.textColor = MainColor;
    today.textAlignment = NSTextAlignmentCenter;
    today.text = @"今日:(m)";
    [backview addSubview:today];
    
    UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-15+0.5+5, 5, zScreenWidth/2-25, 15)];
    total.textColor = MainColor;
    total.textAlignment = NSTextAlignmentCenter;
    total.text = @"总计:(km)";
    [backview addSubview:total];
    
    todaynum = [[UILabel alloc]initWithFrame:CGRectMake(5, 5+15, zScreenWidth/2-25, 60)];
    todaynum.font = [UIFont systemFontOfSize:35];
    todaynum.textAlignment = NSTextAlignmentCenter;
    todaynum.textColor = [UIColor colorHexString:@"bb1c33"];
    if ([todayDis doubleValue]<0) {
        todaynum.text = @"0";
    }else{
        todaynum.text = todayDis;
    }
    
    [backview addSubview:todaynum];
    
    totalnum = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-15+0.5+5, 5+15, zScreenWidth/2-25, 60)];
    totalnum.font = [UIFont systemFontOfSize:35];
    totalnum.textAlignment = NSTextAlignmentCenter;
    totalnum.textColor = [UIColor colorHexString:@"bb1c33"];
    if ([totalDis doubleValue]<0) {
        totalnum.text = @"0.00";
    }else{
        totalnum.text = totalDis;
    }
    totalnum.numberOfLines = 0;
    [backview addSubview:totalnum];
    
    UIButton *CheckBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 74+80+20+120, zScreenWidth-30, 48)];
    CheckBtn.backgroundColor = BtnColor;
    CheckBtn.layer.cornerRadius = 8;
    CheckBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [CheckBtn setTitle:@"轨迹空间" forState:UIControlStateNormal];
    [CheckBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [CheckBtn addTarget:self action:@selector(checkclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CheckBtn];
    
    // Do any additional setup after loading the view.
}

-(void)checkclick{
    GuijiViewController *gjvc = [[GuijiViewController alloc]init];
    [self.navigationController pushViewController:gjvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)followerDidUpdate:(Follower *)follower {
    todaynum.text = [NSString stringWithFormat:@"%.2f", [follower totalDistanceWithUnit:DistanceUnitMiles]];
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
