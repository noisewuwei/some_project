//
//  LonginController.m
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "LonginController.h"
#import "HTTPRequest.h"
#import <ShareSDK/ShareSDK.h>
#import "ZJStaticFunction.h"
#import "DetailController.h"
#import "ZJStoreDefaults.h"
#import "ShippAddressController.h"
#import "ThirdLoginView.h"
#import "FastLonginController.h"
#import "ForgetOrRegisterController.h"
#import "RegisterViewController.h"
#import "LUViewController.h"
#import "UnionViewController.h"
#import "ForgetOrRegisterController.h"
#import "SettingPassController.h"

@interface LonginController (){
    NSString *name;
    NSString *label;
    NSString *image;
    SSDKPlatformType platformType;
}
@property (nonatomic,strong) UITextField *numText;
@property (nonatomic,strong) UITextField *passText;
@property (nonatomic,strong) UIButton *loginButton;

@property(nonatomic,copy)CallBlock TabbarcallBlock;
/* 第三方登录 */
@property(nonatomic,weak) ThirdLoginView     *thirdView;
@end

@implementation LonginController

+(BOOL)shouldLongin{
    NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
    BOOL isLogin = user_id && user_id.length>0;
    return isLogin;
}

+(BOOL)isLongin:(UIViewController*)weakSelf completion:(CallBlock)callBlock{
    NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
    BOOL isLogin = user_id && user_id.length>0;
    if (!isLogin) {
        LonginController *login = [[LonginController alloc] init];
        login.TabbarcallBlock = callBlock;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        nav.navigationBarHidden = NO;
        [weakSelf presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    
    return isLogin;
}

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
    
    NSDictionary *dic = @{@"lock":@"YYYZM"};
    
    [HTTPRequest postWithURL:@"check_YY" params:dic ProgressHUD:nil controller:self response:^(id json) {
        NSLog(@"heheheh:%@",json);
        [ZJStoreDefaults setObject:json forKey:@"YYYZMKG"];
    } error400Code:^(id failure) {
        
    }];
    
    self.view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    self.navigationItem.title = @"优居客登录";
    
    [self createBarLeftWithImage:@"nav_return.png"];
    
    UIView *wview = [[UIView alloc]initWithFrame:CGRectMake(0, 87, zScreenWidth, 50)];
    wview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wview];
    UIView *secondview = [[UIView alloc]initWithFrame:CGRectMake(0, 87+50, zScreenWidth, 50)];
    secondview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondview];
  
    
    UILabel *numlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 87, 50, 50)];
    numlabel.text = @"帐号";
    numlabel.textColor = [UIColor blackColor];
    numlabel.font = [UIFont systemFontOfSize:16];
    
    UILabel *passlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 87+50, 50, 50)];
    passlabel.text = @"密码";
    passlabel.textColor = [UIColor blackColor];
    passlabel.font = [UIFont systemFontOfSize:16];
    
    
    [self.view addSubview:numlabel];
    [self.view addSubview:passlabel];
    
    _numText = [[UITextField alloc]initWithFrame:CGRectMake(15+50, 87, self.view.bounds.size.width-30-50, 50)];
    _passText = [[UITextField alloc]initWithFrame:CGRectMake(15+50, 87+50, self.view.bounds.size.width-30-50, 50)];
//    
//    _numText.borderStyle = UITextBorderStyleRoundedRect;
//    _passText.borderStyle = UITextBorderStyleRoundedRect;

    _numText.backgroundColor = [UIColor whiteColor];
    _passText.backgroundColor = [UIColor whiteColor];
    
    [_passText setSecureTextEntry:YES];

    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 87+100+18, self.view.bounds.size.width-30, 48)];
    _loginButton.backgroundColor = GlobalColor;
    _loginButton.layer.cornerRadius = 8;
    
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginclick) forControlEvents:UIControlEventTouchUpInside];

    _numText.placeholder = @"请输入账号";
    _passText.placeholder = @"请输入密码";
    
    _numText.delegate = self;
    _passText.delegate = self;
    
    _numText.returnKeyType = UIReturnKeyDone;
    _passText.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:_numText];
    [self.view addSubview:_passText];
    [self.view addSubview:_loginButton];
    //[self.view addSubview:nav];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 87+50, zScreenWidth, 1)];
    line.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    [self.view addSubview:line];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(15, CGRectGetMaxY(_loginButton.frame)+20, 80, 30);
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorHexString:@"999999"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [forgetBtn addTarget:self action:@selector(ForgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UIButton *mobileLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    mobileLoginBtn.frame = CGRectMake(zScreenWidth - 150 - 15, CGRectGetMaxY(_loginButton.frame)+20, 150, 30);
    mobileLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [mobileLoginBtn setTitle:@"手机号快捷登录" forState:UIControlStateNormal];
    mobileLoginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [mobileLoginBtn setTitleColor:[UIColor colorHexString:@"3dbf73"] forState:UIControlStateNormal];
    [mobileLoginBtn addTarget:self action:@selector(mobileLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mobileLoginBtn];
    
    [self createBarRightWithImage];

    self.thirdView.frame = CGRectMake(0, CGRectGetMaxY(_loginButton.frame)+10, zScreenWidth, 150);
    CGFloat centerY = (self.view.frame.size.height - CGRectGetMaxY(mobileLoginBtn.frame))/2;
    self.thirdView.center = CGPointMake(self.view.center.x, CGRectGetMaxY(mobileLoginBtn.frame) + centerY);
    
}

#pragma mark --Action

-(void)loginclick{
    
    NSDictionary *dic = @{@"mobile":_numText.text,@"password":_passText.text};
    [HTTPRequest postWithURL:@"f_Login" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
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
        NSLog(@"hehe:%@",failure);
    }];
}

-(void)mobileLoginAction:(UIButton*)sender{
    FastLonginController *fastLngin = [[FastLonginController alloc] init];
    fastLngin.TabbarcallBlock = self.TabbarcallBlock;
    [self.navigationController pushViewController:fastLngin animated:YES];
}

-(void)ForgetAction:(UIButton*)sender{
    ForgetOrRegisterController *forget = [[ForgetOrRegisterController alloc]init];
    forget.regisType = TypeForgotPassword;
    [self.navigationController pushViewController:forget animated:YES];
}
-(void)showRegisterClick:(UIButton *)sender{
    NSLog(@"注册");
    ForgetOrRegisterController *registerVC = [[ForgetOrRegisterController alloc]init];
    registerVC.regisType = TyperRegister;
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)createBarRightWithImage{
    UIButton *remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
    [remindBtn setTitle:@"注册" forState:UIControlStateNormal];
    remindBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [remindBtn setTitleColor:[UIColor colorHexString:@"3dbf73"] forState:UIControlStateNormal];
    remindBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [remindBtn addTarget:self action:@selector(showRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :remindBtn];
    self.navigationItem.rightBarButtonItem = ubar;
    
}

//猪猪 添加第三方登录
-(void)thirdLoginAction:(LoginType)loginType{
    NSString *Ltype;
    
    if (loginType == LoginTypeQQ) {
        platformType = SSDKPlatformTypeQQ;
        Ltype = @"qq";
        label = @"亲爱的QQ用户";
    }else if (loginType == LoginTypeWechat){
        platformType = SSDKPlatformTypeWechat;
        Ltype = @"wx";
        label = @"亲爱的微信用户";
    }else if (loginType == LoginTypeSina){
        platformType = SSDKPlatformTypeSinaWeibo;
    }else{
        platformType = SSDKPlatformTypeUnknown;
    }

    
    if (platformType == SSDKPlatformTypeUnknown) {
        [ZJStaticFunction alertView:self.view msg:@"不好意思，出错了！"];
        return;
    }
    [self.Hud show:YES];
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         [self.Hud hide:YES];
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"icon=%@",user.icon);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             name = user.nickname;
             image = user.rawData[@"figureurl_qq_2"]?user.rawData[@"figureurl_qq_2"] : user.icon;
             NSDictionary *dic = @{@"openId":user.uid,@"type":Ltype,@"nickname":user.nickname,@"avatar":image,@"pwd":@"yjk_wx_login"};
             NSLog(@"%@",dic);
             [self loadDataFormServer:@"get_user_is_exists" params:dic];
             
         }
         else if (state == SSDKResponseStateFail){
             [ZJStaticFunction alertView:self.view msg:@"授权失败"];
         }
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

-(void)loadDataFormServer:(NSString *)url  params:(NSDictionary *)param
{
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:nil response:^(id json) {
        NSLog(@"%@",json);
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
            [ZJStoreDefaults setObject:[NSNumber numberWithUnsignedInteger:platformType] forKey:SDKPlatformType];
            
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
        NSLog(@"hehe:%@",failure);
        NSDictionary *dic = (NSDictionary*)failure;
        NSString *code = [dic valueForKey:@"error"];
        if ([code intValue]==405) {
            UnionViewController *unvc = [[UnionViewController alloc]init];
            unvc.dic = [NSMutableDictionary dictionaryWithDictionary:param];
            unvc.dear = label;
            unvc.name = name;
            unvc.head = image;
            unvc.platformType = platformType;
            [self.navigationController pushViewController:unvc animated:YES];
        }else{
            [ZJStaticFunction alertView:self.view msg:[dic valueForKey:@"message"]];
        }
    }];
    
}

//http://prebk.youjuke.com/api/get_user_is_exists
//重写返回事件
-(void)showLeft:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消登录");
    }];
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

-(ThirdLoginView*)thirdView{
    if (!_thirdView) {
        ThirdLoginView *third = [[ThirdLoginView alloc] initWithFrame:CGRectMake(0, 0, 400, 100)];
        __weak typeof (self)weakSelf = self;
        [third setClickLogin:^(LoginType type) {
            [weakSelf thirdLoginAction:type];
        }];
        
        third.hidden = NO;
        [self.view addSubview:third];
        _thirdView = third;
    }
    
    return _thirdView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
