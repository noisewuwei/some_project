//
//  BaseViewController.m
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "BaseViewController.h"

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
    btnb.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
