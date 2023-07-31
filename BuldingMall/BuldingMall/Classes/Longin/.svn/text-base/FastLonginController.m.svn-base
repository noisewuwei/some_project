//
//  FastLonginController.m
//  BuldingMall
//
//  Created by Jion on 2016/10/24.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "FastLonginController.h"

@interface FastLonginController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *numText;
@property (nonatomic,strong) UITextField *passText;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *verifyButton;
@property (retain) MBProgressHUD *HUD;
@property (nonatomic,strong) NSString *getCodereturn;
@property (nonatomic,strong) UIButton *buttonbeh;

@end

@implementation FastLonginController

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
    self.navigationItem.title = @"无密码快捷登录";
    
    [self createBarLeftWithImage:@"nav_return.png"];
    
    _numText = [[UITextField alloc]initWithFrame:CGRectMake(15, 87, self.view.bounds.size.width-30, 50)];
    _passText = [[UITextField alloc]initWithFrame:CGRectMake(15, 87+50, self.view.bounds.size.width-30, 50)];
    _verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_numText.bounds.size.width-105, 64+23+10, 105, 30)];
    _numText.borderStyle = UITextBorderStyleRoundedRect;
    _passText.borderStyle = UITextBorderStyleRoundedRect;
    _verifyButton.layer.cornerRadius = 4;
    _verifyButton.backgroundColor = GlobalColor;
    _numText.backgroundColor = [UIColor whiteColor];
    _passText.backgroundColor = [UIColor whiteColor];
    //    _passText.text = @"94733"; //写死验证码
    //    _numText.text = @"13101899061"; //写死手机号码
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 87+100+18, self.view.bounds.size.width-30, 48)];
    _loginButton.backgroundColor = GlobalColor;
    _loginButton.layer.cornerRadius = 8;
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_verifyButton addTarget:self action:@selector(getverify) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setTitle:@"快速登录" forState:UIControlStateNormal];
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
    
    
    UILabel *labelfront = [[UILabel alloc]initWithFrame:CGRectMake(50, 280, 150, 30)];
    labelfront.font = [UIFont systemFontOfSize:16];
    labelfront.textColor = [UIColor colorHexString:@"999999"];
    labelfront.text = @"收不到短信？需要";
    labelfront.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:labelfront];
    
    _buttonbeh = [[UIButton alloc]initWithFrame:CGRectMake(200, 280, 120, 30)];
    [_buttonbeh setTitle:@"语音验证码" forState:UIControlStateNormal];
    [_buttonbeh setTitleColor:[UIColor colorHexString:@"3dbf73"] forState:UIControlStateNormal];
    _buttonbeh.titleLabel.font = [UIFont systemFontOfSize:16];
    _buttonbeh.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_buttonbeh addTarget:self action:@selector(getvoice) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_buttonbeh];
    
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
    if (_passText.text.length==5) {
        
        NSDictionary *dic = @{@"mobile":_numText.text,@"code":_passText.text};
        [HTTPRequest postWithURL:@"Login" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
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
            
        }];
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请填写正确的验证码"];
    }
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消登录");
    }];
}


-(void)getvoice{

    if ([ZJStaticFunction isMobileNumber:_numText.text]==YES) {
        
        UIColor *maincolor = [UIColor colorHexString:@"3dbf73"];
        UIColor *countcolor = [UIColor colorHexString:@"999999"];
        [self mysetTheCountdownButton:_buttonbeh startWithTime:15 title:@"语音验证码" countDownTitle:@"语音验证码" mainColor:maincolor countColor:countcolor];
        
        NSDictionary *dic = @{@"mobile":_numText.text,@"yytype":@"1"};
        
        [HTTPRequest postWithURL:@"getCode" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
            NSLog(@"1111111");
            NSLog(@"heheheheh:%@",json);
            NSLog(@"2222222");
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
        NSLog(@"error");
        
    }
    
    
}



-(void)getverify{

    if ([ZJStaticFunction isMobileNumber:_numText.text]==YES) {
        UIColor *maincolor = GlobalColor;
        UIColor *countcolor = [UIColor colorHexString:@"#b8b8b8"];
        [self setTheCountdownButton:_verifyButton startWithTime:59 title:@"重新获取" countDownTitle:@"重新发送" mainColor:maincolor countColor:countcolor];
        
        NSDictionary *dic = @{@"mobile":_numText.text,@"yytype":@"0"};
        
        [HTTPRequest postWithURL:@"getCode" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
            NSString *code;
            if ([json isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary*)json;
                code = [NSString stringWithFormat:@"%@",dict[@"message"]];
            }else{
                code = [NSString stringWithFormat:@"%@",json];
            }
            _getCodereturn = code;
            NSLog(@"%@",_getCodereturn);
        } error400Code:^(id failure) {
            
        }];
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"手机号码格式不正确"];
        NSLog(@"error");
        
    }
}

#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _numText) {
        [_numText resignFirstResponder];
    }else if (textField == _passText){
        [_passText resignFirstResponder];
    }
    return YES;
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
