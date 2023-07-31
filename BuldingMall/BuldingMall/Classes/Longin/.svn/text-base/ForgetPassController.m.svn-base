//
//  ForgetPassController.m
//  BuldingMall
//
//  Created by zfy on 2016/10/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ForgetPassController.h"
#import "SettingPassController.h"

#define kcodeurl @"get_identifying_code"//忘记密码 的验证码接口
#define kgetcodeurl @"getCode"//语音的验证码的接口
@interface ForgetPassController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *yantf;
    UIButton *yanbtn;
    UIButton *yuyi;
    
    
}
@property(nonatomic,strong)NSString *getCodereturn;
@property (retain) MBProgressHUD *HUD;
@end

@implementation ForgetPassController

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
    self.title = @"密码找回";
    [self createBarLeftWithImage:@"nav_return.png"];
    
    
    [self setuipass];
    
    
    
    
}
-(void)setuipass
{
    UILabel *tilab = [[UILabel alloc]initWithFrame:CGRectMake(15, 89, zScreenWidth-30, 30)];
//    tilab.text = [NSString stringWithFormat:@"请输入%@收到的短信验证码",@"15294893103"];
    NSString *tel = [NSString stringWithFormat:@"%@",self.telname];
    NSString *xingtel = [tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    tilab.text =[NSString stringWithFormat:@"请输入%@收到的短信验证码",xingtel];
    tilab.font = [UIFont systemFontOfSize:15.0];
    tilab.textColor = [UIColor colorHexString:@"#999999"];
    [self.view addSubview:tilab];
    
    
    UIView *midview = [[UIView alloc]initWithFrame:CGRectMake(0, tilab.frame.origin.y+50, zScreenWidth, 50)];
    midview.backgroundColor = [UIColor whiteColor];
    
    yantf = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, zScreenWidth-145, 40)];
    yantf.placeholder = @"请输入验证码";
//    yantf.borderStyle = UITextBorderStyleRoundedRect;
   
    yantf.delegate = self;
    yantf.returnKeyType = UIReturnKeyDone;
    [midview addSubview:yantf];
    
    yanbtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-120, 5, 110, 40)];
    yanbtn.backgroundColor = GlobalColor;
    [yanbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanbtn addTarget:self action:@selector(getverifdfd) forControlEvents:UIControlEventTouchUpInside];
    [midview addSubview:yanbtn];
    
    [self.view addSubview:midview];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, midview.frame.origin.y+90, zScreenWidth-30, 50)];
    btn.backgroundColor = GlobalColor;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(netbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIView *yanview = [[UIView alloc]initWithFrame:CGRectMake(50, btn.frame.origin.y+75, zScreenWidth-100, 30)];

    UILabel *yuyilab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    yuyilab.text = @"收不到短信?需要";
    yuyilab.font = [UIFont systemFontOfSize:16.0];
    yuyilab.textColor = [UIColor grayColor];
    [yanview addSubview:yuyilab];
    
    
    yuyi = [[UIButton alloc]initWithFrame:CGRectMake(yuyilab.frame.origin.x+125, 0,110, 30)];
    [yuyi setTitle:@"语音验证码" forState:UIControlStateNormal];
    yuyi.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [yuyi setTitleColor:[UIColor colorHexString:@"3dbf73"] forState:UIControlStateNormal];
    [yuyi addTarget:self action:@selector(getvoicebtn) forControlEvents:UIControlEventTouchUpInside];
    [yanview addSubview:yuyi];

    
    [self.view addSubview:yanview];
    
    
}

-(void)getverifdfd
{
    if ([ZJStaticFunction isMobileNumber:self.telname]==YES)
    {
        UIColor *maincolor = GlobalColor;
        UIColor *countcolor = [UIColor colorHexString:@"#b8b8b8"];
        
        [self setTheCountdownButton:yanbtn startWithTime:59 title:@"重新获取" countDownTitle:@"重新发送" mainColor:maincolor countColor:countcolor];
        
        NSDictionary *dic = @{@"mobile":self.telname};
        
        [HTTPRequest postWithURL:kcodeurl params:dic ProgressHUD:_HUD controller:self response:^(id json) {
            
            NSLog(@"json%@",json);
            
            NSString *code;
//            if ([json isKindOfClass:[NSDictionary class]])
//            {
//                NSDictionary *dict = (NSDictionary*)json;
//                code = [NSString stringWithFormat:@"%@",dict[@"message"]];
//            }
//            else
//            {
//                code = [NSString stringWithFormat:@"%@",json];
//            }
            
            NSDictionary *dict = (NSDictionary *)json;
            code = [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]];
            _getCodereturn = code;
            NSLog(@"getcoderturn%@",_getCodereturn);
        } error400Code:^(id failure) {
            
        }];

    }
    else
    {
        [ZJStaticFunction alertView:self.view msg:@"手机格式不正确"];
        
    }
   
    
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
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                button.userInteractionEnabled =YES;
                
                if ([title isEqualToString:@"语音验证码"])
                {
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@(%@)",subTitle,timeStr]forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                button.userInteractionEnabled =NO;
                
                if ([title isEqualToString:@"语音验证码"])
                {
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                }
                
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
-(void)getvoicebtn
{
    if ([ZJStaticFunction isMobileNumber:self.telname]==YES)
    {
        UIColor *maincolor = [UIColor colorHexString:@"3dbf73"];
        UIColor *countcolor = [UIColor colorHexString:@"999999"];
        [self setTheCountdownButton:yuyi startWithTime:15 title:@"语音验证码" countDownTitle:@"语音验证码" mainColor:maincolor countColor:countcolor];
       
        
        
         NSDictionary *dic = @{@"mobile":self.telname,@"yytype":@"1"};
        
        [HTTPRequest postWithURL:kgetcodeurl params:dic ProgressHUD:_HUD controller:self response:^(id json) {
            
            NSLog(@"json%@",json);
            
            NSString *code;
            if ([json isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dict = (NSDictionary*)json;
                code = [NSString stringWithFormat:@"%@",dict[@"message"]];
            }
            else
            {
                code = [NSString stringWithFormat:@"%@",json];
            }
            _getCodereturn = code;
            NSLog(@"%@",_getCodereturn);
            [ZJStaticFunction alertView:self.view msg:@"正在拨打您的手机\r\n请注意来电!"];
            
        } error400Code:^(id failure) {
            
        }];

        

    }
    else
    {
        [ZJStaticFunction alertView:self.view msg:@"手机格式不正确"];
        
    }
    
  

    
    
}
-(void)netbtnclick:(UIButton *)netbtn
{
    
//    NSString *yanma = [ZJStaticFunction trimSpaceInTextField:yantf.text];
    
    if ([yantf.text isEqualToString:_getCodereturn])
    {
        
        SettingPassController *setting = [[SettingPassController alloc]init];
        setting.telphone = self.telname;
        [self.navigationController pushViewController:setting animated:YES];

        
    }
    else
    {
        
        [ZJStaticFunction alertView:self.view msg:@"请填写正确的验证码"];
        
       
    }
    
   
    
}
-(void)showLeft:(UIButton *)leftbtn
{
    NSLog(@"11");
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"" message:@"点击“返回”将中断密码找回，是否返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 11111;
    aler.delegate = self;
    [aler show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11111)
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
    if (textField == yantf)
    {
        [yantf resignFirstResponder];
        
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
