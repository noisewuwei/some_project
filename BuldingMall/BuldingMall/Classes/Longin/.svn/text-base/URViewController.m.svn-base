//
//  URViewController.m
//  BuldingMall
//
//  Created by noise on 2016/10/28.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "URViewController.h"

@interface URViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *numText;
@property (nonatomic,strong) UITextField *passText;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *verifyButton;
@property (retain) MBProgressHUD *HUD;
@property (nonatomic,strong) NSString *getCodereturn;
@property (nonatomic,strong) UIButton *buttonbeh;
@property (nonatomic,strong) UITextField *pwtext;
@property (nonatomic,strong) UITextField *pwagtext;

@end

@implementation URViewController

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
    
    self.view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    self.navigationItem.title = @"快速注册";
    
    [self createBarLeftWithImage:@"nav_return.png"];
    
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 64+13, zScreenWidth, 87+50+18+5+18+18+50+50)];
    whiteview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteview];
    
    //    UIView *grayview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 23)];
    //    grayview.backgroundColor = [UIColor blackColor];
    //
    //    [self.view addSubview:grayview];
    
    _numText = [[UITextField alloc]initWithFrame:CGRectMake(15, 87+5, self.view.bounds.size.width-30, 50)];
    _passText = [[UITextField alloc]initWithFrame:CGRectMake(15, 87+50+18, self.view.bounds.size.width-30-105-23, 50)];
    _verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_passText.bounds.size.width+23+15, 87+50+18+5, 105, 40)];
    _numText.borderStyle = UITextBorderStyleRoundedRect;
    _passText.borderStyle = UITextBorderStyleRoundedRect;
    _verifyButton.layer.cornerRadius = 4;
    _verifyButton.backgroundColor = GlobalColor;
    _numText.backgroundColor = [UIColor whiteColor];
    _passText.backgroundColor = [UIColor whiteColor];
    //    _passText.text = @"94733"; //写死验证码
    //    _numText.text = @"13101899061"; //写死手机号码
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 87+100+18+195, self.view.bounds.size.width-30, 48)];
    _loginButton.backgroundColor = GlobalColor;
    _loginButton.layer.cornerRadius = 8;
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_verifyButton addTarget:self action:@selector(getverify) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginclick) forControlEvents:UIControlEventTouchUpInside];
    
    _numText.placeholder = @"请输入手机号";
    _passText.placeholder = @"请输入验证码";
    
    _numText.delegate = self;
    _passText.delegate = self;
    
    _numText.returnKeyType = UIReturnKeyDone;
    _passText.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:_numText];
    [self.view addSubview:_verifyButton];
    [self.view addSubview:_passText];
    [self.view addSubview:_loginButton];
    
    
    UILabel *labelfront = [[UILabel alloc]initWithFrame:CGRectMake(30, 87+100+18+200+45, 150, 30)];
    labelfront.font = [UIFont systemFontOfSize:16];
    labelfront.textColor = [UIColor colorHexString:@"999999"];
    labelfront.text = @"收不到短信？需要";
    labelfront.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:labelfront];
    
    
    
    _buttonbeh = [[UIButton alloc]initWithFrame:CGRectMake(180, 87+100+18+200+45, 120, 30)];
    [_buttonbeh setTitle:@"语音验证码" forState:UIControlStateNormal];
    [_buttonbeh setTitleColor:[UIColor colorHexString:@"3dbf73"] forState:UIControlStateNormal];
    _buttonbeh.titleLabel.font = [UIFont systemFontOfSize:16];
    _buttonbeh.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_buttonbeh addTarget:self action:@selector(getvoice) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonbeh];
    
    
    _pwtext = [[UITextField alloc]initWithFrame:CGRectMake(15, 87+50+18+5+18+40, self.view.bounds.size.width-30, 50)];
    [_pwtext setSecureTextEntry:YES];
    _pwagtext = [[UITextField alloc]initWithFrame:CGRectMake(15, 87+50+18+5+18+18+50+35, self.view.bounds.size.width-30, 50)];
    [_pwagtext setSecureTextEntry:YES];
    _pwtext.borderStyle = UITextBorderStyleRoundedRect;
    _pwagtext.borderStyle = UITextBorderStyleRoundedRect;
    _pwtext.backgroundColor = [UIColor whiteColor];
    _pwagtext.backgroundColor = [UIColor whiteColor];
    
    _pwtext.placeholder = @"请设置6-20位登录密码";
    _pwagtext.placeholder = @"请再次输入密码";
    
    UILabel *seelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 87+50+18+5+18+18+50+50+48, 80, 20)];
    seelabel.text = @"密码可见";
    seelabel.font = [UIFont systemFontOfSize:14];
    seelabel.textColor = [UIColor colorHexString:@"999999"];
    
    UISwitch *sbtn = [[UISwitch alloc]initWithFrame:CGRectMake(zScreenWidth-15-40-10, 87+50+18+5+18+18+50+50+43, 80, 15)];
    [sbtn setOn:NO];
    [sbtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sbtn];
    
    [self.view addSubview:seelabel];
    
    UILabel *tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 87+50+18+5+18+18+50+50+50+10+20, zScreenWidth-30, 20)];
    tiplabel.text = @"备注：密码6-20位字母或者数字，字母区分大小写";
    tiplabel.font = [UIFont systemFontOfSize:12];
    tiplabel.textColor = [UIColor colorHexString:@"999999"];
    
    [self.view addSubview:tiplabel];
    
    _pwtext.delegate = self;
    _pwagtext.delegate = self;
    
    _pwtext.returnKeyType = UIReturnKeyDone;
    _pwagtext.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:_pwtext];
    [self.view addSubview:_pwagtext];
    
    id obj = [ZJStoreDefaults getObjectForKey:@"YYYZMKG"];
    NSLog(@"yyyzmkg:%@",obj);
    if ([obj intValue]== 1) {
        labelfront.hidden = YES;
        _buttonbeh.hidden = YES;
    }
    
}

#pragma mark --Action

-(void)loginclick{
    //[_passText.text isEqualToString: _getCodereturn]
    if ([_pwtext.text isEqualToString: _pwagtext.text]) {
        NSString *pass = [ZJStaticFunction trimSpaceInTextField:_pwtext.text];
        NSString *compass = [ZJStaticFunction trimSpaceInTextField:_pwagtext.text];
        
        if (pass.length==0 || compass.length==0)
        {
            [ZJStaticFunction alertView:self.view msg:@"密码不能为空"];
            return;
            
            
        }
        
        if ([ZJStaticFunction trimSpaceInTextField:_pwtext.text].length<6)
        {
            [ZJStaticFunction alertView:self.view msg:@"密码至少6位"];
            return;
            
        }
        
        if ([ZJStaticFunction trimSpaceInTextField:_pwagtext.text].length<6)
        {
            [ZJStaticFunction alertView:self.view msg:@"密码至少6位"];
            return;
            
        }
        
        if ([ZJStaticFunction trimSpaceInTextField:_pwtext.text].length>20)
        {
            [ZJStaticFunction alertView:self.view msg:@"密码不能超过20位"];
            return;
        }
        
        if ([ZJStaticFunction trimSpaceInTextField:_pwagtext.text].length>20)
        {
            [ZJStaticFunction alertView:self.view msg:@"密码不能超过20位"];
            return;
        }
        
        if ([_passText.text isEqualToString: _getCodereturn]) {
            
            [_dic setObject:_numText.text forKey:@"mobile"];
            [_dic setObject:_pwtext.text forKey:@"password"];
            [HTTPRequest postWithURL:@"set_malluser" params:_dic ProgressHUD:_HUD controller:self response:^(id json) {
                NSLog(@"json:%@",json);
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict =(NSDictionary*)json;
                    NSMutableDictionary *userData=[[NSMutableDictionary alloc]init];
                    for (id key in dict.allKeys)
                    {
                        id objc =[dict objectForKey:key];
                        if ([objc isKindOfClass:[NSNull class]]) {
                            objc = @"";
                        }
                        [userData setValue:objc forKey:key];
                    }
                    
                    [ZJStoreDefaults setObject:userData forKey:LoginSucess];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeOrder" object:nil userInfo:nil];
                    NSLog(@"%@",dict);
                    if (self.TabbarcallBlock) {
                        self.TabbarcallBlock();
                    }
                    [self dismissViewControllerAnimated:YES completion:^{
                        NSLog(@"登录成功");
                    }];
                }
                
                
            } error400Code:^(id failure) {
                NSLog(@"fail:%@",failure);
            }];
            
        }else{
            [ZJStaticFunction alertView:self.view msg:@"请填写正确的验证码"];
        }
    }else{
        [ZJStaticFunction alertView:self.view msg:@"两次密码不一致"];
    }
    
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消登录");
    }];
}


-(void)getvoice{
    NSDictionary *dic = @{@"mobile":_numText.text};
    [HTTPRequest postWithURL:@"check_register" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
        if ([ZJStaticFunction isMobileNumber:_numText.text]==YES){
            UIColor *maincolor = [UIColor colorHexString:@"3dbf73"];
            UIColor *countcolor = [UIColor colorHexString:@"999999"];
            [self mysetTheCountdownButton:_buttonbeh startWithTime:15 title:@"语音验证码" countDownTitle:@"语音验证码" mainColor:maincolor countColor:countcolor];
            
            NSDictionary *dic = @{@"mobile":_numText.text,@"yytype":@"1"};
            
            [HTTPRequest postWithURL:@"register_code" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
                NSString *code;
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = (NSDictionary*)json;
                    code = [NSString stringWithFormat:@"%@",dict[@"message"]];
                }else{
                    code = [NSString stringWithFormat:@"%@",json];
                }
                _getCodereturn = code;
                NSLog(@"%@",_getCodereturn);
                [ZJStaticFunction alertView:self.view msg:@"正在拨打您的手机\r\n请注意来电!"];
            } error400Code:^(id failure) {
                
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"手机号码格式不正确"];
        }
    } error400Code:^(id failure) {
        
    }];
    
}


-(void)choose:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [_pwtext setSecureTextEntry:NO];
        [_pwagtext setSecureTextEntry:NO];
        NSLog(@"是");\
    }else {
        [_pwtext setSecureTextEntry:YES];
        [_pwagtext setSecureTextEntry:YES];
        NSLog(@"否");
    }
}



-(void)getverify{
    NSDictionary *dic = @{@"mobile":_numText.text};
    [HTTPRequest postWithURL:@"check_register" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
        if ([ZJStaticFunction isMobileNumber:_numText.text]==YES) {
            UIColor *maincolor = GlobalColor;
            UIColor *countcolor = [UIColor colorHexString:@"#b8b8b8"];
            [self setTheCountdownButton:_verifyButton startWithTime:59 title:@"重新获取" countDownTitle:@"重新发送" mainColor:maincolor countColor:countcolor];
            
            NSDictionary *dic = @{@"mobile":_numText.text,@"yytype":@"0"};
            
            [HTTPRequest postWithURL:@"register_code" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
                NSLog(@"json：%@",json);
                NSString *code;
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = (NSDictionary*)json;
                    code = [NSString stringWithFormat:@"%@",dict[@"message"]];
                }else{
                    code = [NSString stringWithFormat:@"%@",json];
                }
                _getCodereturn = code;
                NSLog(@"code：%@",_getCodereturn);
            } error400Code:^(id failure) {
                NSLog(@"hahahaerror:%@",failure);
            }];
            
        }else{
            [ZJStaticFunction alertView:self.view msg:@"手机号码格式不正确"];
            NSLog(@"error");
            
        }
    } error400Code:^(id failure) {
        
    }];
    

    
}

#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField){
        [textField resignFirstResponder];
    }
    if (textField == _pwagtext || textField == _pwtext) {
        self.view.center = CGPointMake(self.view.center.x, zScreenHeight/2);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    //    self.view.center = CGPointMake(self.view.center.x, zScreenHeight/2);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _pwagtext || textField == _pwtext) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeContentViewPosition:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeContentViewPosition:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    
    
    
}

- (void) changeContentViewPosition:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.view.center = CGPointMake(self.view.center.x, keyBoardEndY-140);
    }];
}

- (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle: title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@(%@)",subTitle,timeStr]forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)mysetTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle: title forState:UIControlStateNormal];
                [button setTitleColor:mColor forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                button.userInteractionEnabled =YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@(%@)",subTitle,timeStr]forState:UIControlStateNormal];
                [button setTitleColor:color forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
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
