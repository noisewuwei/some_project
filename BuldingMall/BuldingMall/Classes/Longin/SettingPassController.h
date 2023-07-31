//
//  SettingPassController.h
//  BuldingMall
//
//  Created by zfy on 2016/10/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();
typedef NS_ENUM(NSUInteger, RLoginType) {
    LTyperRegister,
    LTypeForgotPassword,
};

@interface SettingPassController : BaseViewController
@property (nonatomic,strong)NSString *telphone;
@property (nonatomic,strong)NSString *code;
@property(nonatomic,copy)CallBlock TabbarcallBlock;
@property (nonatomic,assign)RLoginType regisType;
@end
