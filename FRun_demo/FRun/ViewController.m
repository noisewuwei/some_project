//
//  ViewController.m
//  FRun
//
//  Created by noise on 2016/11/5.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+HexString.h"
#import "Define.h"
#import "SuiViewController.h"
#import "GuiViewController.h"
#import "PerViewController.h"

@interface ViewController (){
    UIButton *SuiBtn;
    UIButton *GuiBtn;
    UIButton *PerBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"首页";
    self.navigationController.navigationBarHidden = YES;
    
    SuiBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-99, zScreenHeight/2-24-96, 198, 48)];
    SuiBtn.backgroundColor = BtnColor;
    SuiBtn.layer.cornerRadius = 8;
    SuiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [SuiBtn setTitle:@"随心跑" forState:UIControlStateNormal];
    [SuiBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [SuiBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [SuiBtn addTarget:self action:@selector(Suiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SuiBtn];
    
    GuiBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-99, zScreenHeight/2-24, 198, 48)];
    GuiBtn.backgroundColor = BtnColor;
    GuiBtn.layer.cornerRadius = 8;
    GuiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [GuiBtn setTitle:@"轨迹规划" forState:UIControlStateNormal];
    [GuiBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
    [GuiBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [GuiBtn addTarget:self action:@selector(Guiclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GuiBtn];
    
    PerBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-99, zScreenHeight/2+48+24, 198, 48)];
    PerBtn.backgroundColor = BtnColor;
    PerBtn.layer.cornerRadius = 8;
    PerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [PerBtn setTitle:@"个人域" forState:UIControlStateNormal];
    [PerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [PerBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [PerBtn addTarget:self action:@selector(Perclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PerBtn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)Suiclick{
    NSLog(@"Sui");
    SuiViewController *SuiVc = [[SuiViewController alloc]init];
    [self.navigationController pushViewController:SuiVc animated:YES];
}

- (void)Guiclick{
    NSLog(@"Gui");
    GuiViewController *GuiVc = [[GuiViewController alloc]init];
    [self.navigationController pushViewController:GuiVc animated:YES];
}

- (void)Perclick{
    NSLog(@"Per");
    PerViewController *PerVc = [[PerViewController alloc]init];
    [self.navigationController pushViewController:PerVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
