//
//  UnionViewController.m
//  BuldingMall
//
//  Created by noise on 2016/10/26.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "UnionViewController.h"
#import "ZJStaticFunction.h"
#import "LUViewController.h"
#import "URViewController.h"

@interface UnionViewController ()

@property (nonatomic,strong) UILabel *midLabel;
@property (nonatomic,strong) UILabel *downLabel;
@property (nonatomic,strong) UILabel *blackLabel;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *rnButton;


@end

@implementation UnionViewController

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
    self.title = @"联合登陆";
    
    [self createBarLeftWithImage:@"nav_return.png"];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-40, 64+35, 80, 80)];
    _headImage.image = [ZJStaticFunction changeimagetocilce:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_head]]]];
    
    [self.view addSubview:_headImage];
    
    _dearLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 99+80+25, 100, 20)];
    _dearLabel.textColor = [UIColor colorHexString:@"999999"];
    _dearLabel.font = [UIFont systemFontOfSize:13];
    _dearLabel.text = _dear;
    
    [self.view addSubview:_dearLabel];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 99+80+24, 100, 20)];
    _nameLabel.textColor = [UIColor colorHexString:@"999999"];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.text = _name;
    
    [self.view addSubview:_nameLabel];
    
    _blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 99+80+25+25, zScreenWidth-30, 40)];
    _blackLabel.numberOfLines = 0;
    _blackLabel.textColor = [UIColor colorHexString:@"333333"];
    _blackLabel.font = [UIFont systemFontOfSize:16];
    _blackLabel.text = @"为了给您更好的服务，请关联一个优居客帐号";
    
    [self.view addSubview:_blackLabel];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 99+80+25+30+50, zScreenWidth-30, 0.5)];
    view1.backgroundColor = [UIColor colorHexString:@"cccccc"];
    [self.view addSubview:view1];
    
    _midLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 99+80+25+30+55, 200, 20)];
    _midLabel.textColor = [UIColor colorHexString:@"808080"];
    _midLabel.font = [UIFont systemFontOfSize:13];
    _midLabel.text = @"还没有优居客帐号？";
    
    UIImageView *imagem = [[UIImageView alloc]initWithFrame:CGRectMake(15, 99+80+25+30+55+7, 5, 5)];
    imagem.image = [UIImage imageNamed:@"btn_round.png"];

    [self.view addSubview:imagem];
    [self.view addSubview:_midLabel];
    
    _downLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 99+80+25+30+55+20+90, 200, 20)];
    _downLabel.textColor = [UIColor colorHexString:@"808080"];
    _downLabel.font = [UIFont systemFontOfSize:13];
    _downLabel.text = @"已有优居客帐号？";
    
    UIImageView *imaged = [[UIImageView alloc]initWithFrame:CGRectMake(15, 99+80+25+30+55+20+97, 5, 5)];
    imaged.image = [UIImage imageNamed:@"btn_round.png"];
    
    [self.view addSubview:imaged];
    
    [self.view addSubview:_downLabel];
    
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 99+80+25+30+55+20+10, zScreenWidth-30, 48)];
    _loginButton.backgroundColor = GlobalColor;
    _loginButton.layer.cornerRadius = 8;
    
    [_loginButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginButton];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(15, 99+80+25+30+55+20+80, zScreenWidth/2-30, 0.5)];
    view2.backgroundColor = [UIColor colorHexString:@"cccccc"];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/2+15, 99+80+25+30+55+20+80, zScreenWidth/2-30, 0.5)];
    view3.backgroundColor = [UIColor colorHexString:@"cccccc"];
    [self.view addSubview:view3];
    
    UILabel *orlabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-7.5, 99+80+25+30+55+20+75, 15, 10)];
    orlabel.textColor = [UIColor colorHexString:@"cccccc"];
    orlabel.font = [UIFont systemFontOfSize:12];
    orlabel.textAlignment = NSTextAlignmentCenter;
    orlabel.text = @"or";
    
    [self.view addSubview:orlabel];

    
    _rnButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 99+80+25+30+55+20+115, zScreenWidth-30, 48)];
    _rnButton.backgroundColor = [UIColor whiteColor];
    _rnButton.layer.cornerRadius = 8;
    
    [_rnButton setTitle:@"立即关联" forState:UIControlStateNormal];
    [_rnButton setTitleColor:GlobalColor forState:UIControlStateNormal];
    [_rnButton addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [_rnButton.layer setBorderColor:GlobalColor.CGColor];
    [_rnButton.layer setBorderWidth:1];
    [_rnButton.layer setMasksToBounds:YES];
    
    [self.view addSubview:_rnButton];
    // Do any additional setup after loading the view.
}

-(void)click{
    URViewController *Ruvc = [[URViewController alloc]init];
    Ruvc.dic = _dic;
    [self.navigationController pushViewController:Ruvc animated:YES];
    NSLog(@"快速注册");
}

-(void)btnclick{
    LUViewController *Luvc = [[LUViewController alloc]init];
    Luvc.dic = _dic;
    [self.navigationController pushViewController:Luvc animated:YES];
    NSLog(@"立即关联");
}
-(void)showLeft:(UIButton *)sender{
    if (_platformType) {
        //取消第三方登录授权
        [ShareSDK cancelAuthorize:self.platformType];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
