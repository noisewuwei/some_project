//
//  SettingPassController.m
//  BuldingMall
//
//  Created by zfy on 2016/10/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "SettingPassController.h"
#import "LonginController.h"
#import "ForgetOrRegisterController.h"
#import "VerifyCodeController.h"

#define kcomurl @"reset_password"//修改密码接口
#define Rurl @"register"//修改密码接口
@interface SettingPassController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *passWordTextField;
    UITextField *comfirmTextField;
    
}
@property (retain) MBProgressHUD *HUD;
@end

@implementation SettingPassController

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
    
    if (self.regisType == LTyperRegister) {
        self.title = @"快速注册";
    }else if (self.regisType == LTypeForgotPassword){
        self.title = @"密码找回";
    }else{
        self.title = @"忘记密码或注册";
    }
//    self.title = @"密码找回";
    [self createBarLeftWithImage:@"nav_return.png"];

    [self setpassword];
    
    
}
-(void)setpassword
{
    UILabel *settpass = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, zScreenWidth-30, 30)];

    if (self.regisType == LTyperRegister) {
        settpass.text = @"请设置密码";
    }else if (self.regisType == LTypeForgotPassword){
        settpass.text = @"请设置新密码";
    }
    settpass.textColor = [UIColor colorHexString:@"#999999"];
    [self.view addSubview:settpass];
    
    
    UIView *contview = [[UIView alloc]initWithFrame:CGRectMake(0, settpass.frame.size.height+100, zScreenWidth, 50)];
    contview.backgroundColor = [UIColor whiteColor];
    passWordTextField=[[UITextField alloc] init];
    passWordTextField.frame=CGRectMake(15, 0, zScreenWidth-30, 50);
    //    passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passWordTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    passWordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    passWordTextField.returnKeyType=UIReturnKeyDone;
    //    passWordTextField.keyboardType= UIKeyboardTypePhonePad;
    passWordTextField.placeholder=@"请输入6-20位字符";
    passWordTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    passWordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    passWordTextField.delegate=self;
    passWordTextField.secureTextEntry=YES;
    [contview addSubview:passWordTextField];

    [self.view addSubview:contview];
    
    UIView *queview = [[UIView alloc]initWithFrame:CGRectMake(0, contview.frame.origin.y+52, zScreenWidth, 50)];
    queview.backgroundColor = [UIColor whiteColor];
    comfirmTextField=[[UITextField alloc] init];
    comfirmTextField.frame=CGRectMake(15,0, zScreenWidth-30, 50);
//    comfirmTextField.borderStyle = UITextBorderStyleRoundedRect;
    comfirmTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    comfirmTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    comfirmTextField.returnKeyType=UIReturnKeyDone;
    //    comfirmTextField.keyboardType= UIKeyboardTypePhonePad;
    comfirmTextField.placeholder=@"请再次输入密码";
    comfirmTextField.autocapitalizationType=UITextAutocapitalizationTypeNone; //首字母不大写
    comfirmTextField.autocorrectionType = UITextAutocorrectionTypeNo;// 不执行自动更正单词
    comfirmTextField.delegate=self;
    comfirmTextField.secureTextEntry=YES;
    [queview addSubview:comfirmTextField];

    [self.view addSubview:queview];
    
    
    
    
    UILabel *switlab = [[UILabel alloc]initWithFrame:CGRectMake(15, queview.frame.origin.y+60, 100, 30)];
    switlab.text = @"密码可见";
    switlab.font = [UIFont systemFontOfSize:16];
    switlab.textColor = [UIColor colorHexString:@"#999999"];
    [self.view addSubview:switlab];

    
    
    UISwitch *swit = [[UISwitch alloc]initWithFrame:CGRectMake(zScreenWidth-90, queview.frame.origin.y+60, 80, 15)];
    [swit addTarget:self action:@selector(onchageaction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:swit];
    
    

    UILabel *beilab = [[UILabel alloc]initWithFrame:CGRectMake(15, swit.frame.origin.y+45, zScreenWidth-30, 60)];
    beilab.numberOfLines = 0;
    beilab.text = @"备注:密码由6-20位字母或数字组成，字母需区分大小写";
    beilab.textColor = [UIColor colorHexString:@"#999999"];
    beilab.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:beilab];
    
    
    UIButton *combtn = [[UIButton alloc]initWithFrame:CGRectMake(15, beilab.frame.origin.y+80, zScreenWidth-30, 50)];
    combtn.backgroundColor = GlobalColor;
    [combtn setTitle:@"完成" forState:UIControlStateNormal];
    combtn.layer.cornerRadius=5;
    [combtn addTarget:self action:@selector(ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:combtn];
    
    
}
-(void)ButtonClicked
{
    
    NSString *pass = [ZJStaticFunction trimSpaceInTextField:passWordTextField.text];
    NSString *compass = [ZJStaticFunction trimSpaceInTextField:comfirmTextField.text];
    
    if (pass.length==0 || compass.length==0)
    {
        [ZJStaticFunction alertView:self.view msg:@"密码不能为空"];
        return;
        
        
    }
    
    if ([ZJStaticFunction trimSpaceInTextField:passWordTextField.text].length<6)
    {
        [ZJStaticFunction alertView:self.view msg:@"密码至少6位"];
        return;
        
    }
    
    if ([ZJStaticFunction trimSpaceInTextField:comfirmTextField.text].length<6)
    {
        [ZJStaticFunction alertView:self.view msg:@"密码至少6位"];
        return;
        
    }
    
    if ([ZJStaticFunction trimSpaceInTextField:passWordTextField.text].length>20)
    {
        [ZJStaticFunction alertView:self.view msg:@"密码不能超过20位"];
        return;
    }
    
    if ([ZJStaticFunction trimSpaceInTextField:comfirmTextField.text].length>20)
    {
        [ZJStaticFunction alertView:self.view msg:@"密码不能超过20位"];
        return;
    }
    
    if (![[ZJStaticFunction trimSpaceInTextField:passWordTextField.text] isEqualToString:[ZJStaticFunction trimSpaceInTextField:comfirmTextField.text]])
    {
        [ZJStaticFunction alertView:self.view msg:@"两次密码不一致"];
        return;
        
        
    }
    
    if (self.regisType == LTyperRegister) {
        [self loadDataFormServer:Rurl params:@{@"mobile":self.telphone,@"code":self.code,@"password":comfirmTextField.text}];
    }else if (self.regisType == LTypeForgotPassword){
        [self loadDataFormServer:kcomurl params:@{@"mobile":self.telphone,@"password":comfirmTextField.text}];
    }
    
//    [self loadDataFormServer:kcomurl params:@{@"mobile":self.telphone,@"password":comfirmTextField.text}];
    
    
}
-(void)loadDataFormServer:(NSString *)url  params:(NSDictionary *)param
{
    
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.HUD controller:self response:^(id json) {
        NSLog(@"修改密码%@",json);
        
        //跳到 登录后的界面中去
        if ([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = (NSDictionary*)json;
            NSMutableDictionary *userdata = [[NSMutableDictionary alloc]init];
            for (id key in dict.allKeys)
            {
                id objc = [dict objectForKey:key];
                
                if ([objc isKindOfClass:[NSNull class]])
                {
                    objc = @"";
                    
                }
                
                [userdata setValue:objc forKey:key];
                
                
            }
            
            [ZJStoreDefaults setObject:userdata forKey:LoginSucess];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeOrder" object:nil userInfo:nil];
            NSLog(@"%@",dict);
            if (self.TabbarcallBlock)
            {
                self.TabbarcallBlock();
                
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"登录成功");
            }];
            
            
        }
 
        
        
        
    } error400Code:^(id failure)
     {
         
     }];
    
}

-(void)onchageaction:(UISwitch *)sender

{
    NSLog(@"改变开关按钮");
    
    if (sender.on == YES)
    {
        NSLog(@"开关开着");
        
         passWordTextField.secureTextEntry=NO;
         comfirmTextField.secureTextEntry=NO;
        
    }
    else
    {
        NSLog(@"开关关着");
        
         passWordTextField.secureTextEntry=YES;
         comfirmTextField.secureTextEntry=YES;
        
    }
    
    
}
//左上角点击返回按钮触发事件
-(void)showLeft:(UIButton *)leftbtn
{
    NSLog(@"11111");
    
    if (self.regisType == LTyperRegister) {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"" message:@"点击“返回”将中断注册，是否返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aler.tag = 1111;
        aler.delegate = self;
        [aler show];
    }else if (self.regisType == LTypeForgotPassword){
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"" message:@"点击“返回”将中断密码找回，是否返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aler.tag = 1111;
        aler.delegate = self;
        [aler show];
    }
//    
//    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"" message:@"点击“返回”将中断密码找回，是否返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    aler.tag = 1111;
//    aler.delegate = self;
//    [aler show];
    
    
   
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1111)
    {
        if (buttonIndex == 1)
        {
            NSLog(@"11111");
            
         [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            NSLog(@"22222");
            
        }
    }
}

#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == passWordTextField)
    {
        [passWordTextField resignFirstResponder];
        
    }
    
    if (textField == comfirmTextField)
    {
        [comfirmTextField resignFirstResponder];
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
