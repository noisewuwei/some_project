//
//  SettingController.m
//  BuldingMall
//
//  Created by zfy on 16/9/27.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "SettingController.h"
#import "LonginController.h"

@interface SettingController ()
{
    NSDictionary * dataDic;
    
}
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    
     dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
    
//     NSString *ID = dataDic[@"id"];
    
    
    [self getSet];
    
    
}

-(void)getSet
{
    
    
    
    UIView *setView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, zScreenWidth, 90)];
    setView.backgroundColor = [UIColor whiteColor];
    UILabel *touLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 35, 50, 30)];
    touLab.text = @"头像";
    touLab.font = [UIFont systemFontOfSize:16.0];
    touLab.textColor = [UIColor colorHexString:@"#333333"];
    [setView addSubview:touLab];
    
    
    UIImageView *_touImg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-83, 10, 70, 70)];
    NSString *touImg  = dataDic[@"avatar"];
    [_touImg sd_setImageWithURL:[NSURL URLWithString:touImg] placeholderImage:[UIImage imageNamed:@"Head-portrait-1.png"]];
    _touImg.layer.cornerRadius = 35.0;
    _touImg.layer.masksToBounds = YES;
    [setView addSubview:_touImg];
    
    [self.view addSubview:setView];
    
    

    
    UIView *nameView =[[UIView alloc]initWithFrame:CGRectMake(0, setView.frame.size.height + 17, zScreenWidth, 50)];
    nameView.backgroundColor =[UIColor whiteColor];
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 50, 30)];
    nameLab.text = @"用户名";
    nameLab.font = [UIFont systemFontOfSize:16.0];
    nameLab.textColor = [UIColor colorHexString:@"#333333"];
    [nameView addSubview:nameLab];
    
    
    UILabel *nameLabb = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-117, 10, zScreenWidth-100, 30)];
    nameLabb.text = dataDic[@"username"];
    nameLabb.font = [UIFont systemFontOfSize:16.0];
    nameLabb.textColor = [UIColor colorHexString:@"#999999"];
    [nameView addSubview:nameLabb];

    [self.view addSubview:nameView];
    
    
    UIButton *logOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-114, zScreenWidth, 50)];
    logOutBtn.backgroundColor = GlobalColor;
    [logOutBtn setTitle:@"退出当前账户" forState:UIControlStateNormal];
    logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutBtn];
    
    
}

-(void)logOutBtnClick:(UIButton *)logOut
{
    NSNumber *PlatformType = [ZJStoreDefaults getObjectForKey:SDKPlatformType];
    if (PlatformType) {
        //取消第三方登录授权
        [ShareSDK cancelAuthorize:[PlatformType integerValue]];
        
        [ZJStoreDefaults removeObjectForKey:SDKPlatformType];
    }
    
    [ZJStoreDefaults removeObjectForKey:LoginSucess];
    
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
