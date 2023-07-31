//
//  ForgetViewController.m
//  BuldingMall
//
//  Created by noise on 2016/10/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ForgetOrRegisterController.h"
#import "VerifyCodeController.h"

@interface ForgetOrRegisterController ()<UITextFieldDelegate>
{
    UITextField *passtf;
    
}
@end

@implementation ForgetOrRegisterController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    if (self.regisType == TyperRegister) {
        self.title = @"快速注册";
    }else if (self.regisType == TypeForgotPassword){
        self.title = @"密码找回";
    }else{
        self.title = @"忘记密码或注册";
    }
    
    [self createBarLeftWithImage:@"nav_return.png"];
    
    [self createUIFD];
    
    
}
//布局界面
-(void)createUIFD
{
    
    
    UIView *telview = [[UIView alloc]initWithFrame:CGRectMake(0, 87, zScreenWidth, 50)];
    telview.backgroundColor = [UIColor whiteColor];
    
    UILabel *tellab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
    tellab.text = @"手机号";
    [telview addSubview:tellab];
    
    
    passtf = [[UITextField alloc]initWithFrame:CGRectMake(tellab.frame.origin.x+70, 6, zScreenWidth-60, 40)];
    passtf.placeholder = @"请输入手机号码";
    //    passtf.borderStyle = UITextBorderStyleRoundedRect;
//    passtf.text = @"13101899061";
//    passtf.text = @"15692122163";
    passtf.backgroundColor = [UIColor whiteColor];
    passtf.placeholder = @"请输入电话号码";
    passtf.delegate = self;
    passtf.returnKeyType = UIReturnKeyDone;
    [telview addSubview:passtf];
    
    [self.view addSubview:telview];
    
    
  
    
    UIButton *nextbtn = [[UIButton alloc]initWithFrame:CGRectMake(15,telview.frame.size.height+137, zScreenWidth-30, 50)];
    nextbtn.backgroundColor = GlobalColor;
    nextbtn.layer.cornerRadius = 5;
    [nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextbtn addTarget:self action:@selector(nextbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbtn];
    
    
}
-(void)nextbtnclick
{
    
    NSString *mobile = [ZJStaticFunction trimSpaceInTextField:passtf.text];
    
    if (mobile.length==0)
    {
        [ZJStaticFunction alertView:self.view msg:@"请输入手机号"];

        return;
        
    }
    
    if (![ZJStaticFunction isMobileNumber:mobile])
    {
        [ZJStaticFunction alertView:self.view msg:@"手机格式不正确"];
        
        return;
        

    }
    
    VerifyCodeController *verifyCodeVC = [[VerifyCodeController alloc]init];
    
    verifyCodeVC.telname=passtf.text;
    NSDictionary *dic = @{@"mobile":passtf.text};
    
    if (self.regisType == TyperRegister) {
        verifyCodeVC.regisType = VTyperRegister;
        
        [HTTPRequest postWithURL:@"check_register" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            [self.navigationController pushViewController:verifyCodeVC animated:YES];
        } error400Code:^(id failure) {
            
        }];
    }else if (self.regisType == TypeForgotPassword){
        verifyCodeVC.regisType = VTypeForgotPassword;
        [HTTPRequest postWithURL:@"check_register" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            [ZJStaticFunction alertView:self.view msg:@"该号码未注册"];
        } error400Code:^(id failure) {
            [self.navigationController pushViewController:verifyCodeVC animated:YES];
        }];
    }
    
    
    
    
    
    
    
}
#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == passtf)
    {
        [passtf resignFirstResponder];
        
    }
       return YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
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
