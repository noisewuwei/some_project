//
//  RegisterViewController.h
//  BuldingMall
//
//  Created by noise on 2016/10/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();

@interface RegisterViewController : BaseViewController

@property(nonatomic,copy)CallBlock TabbarcallBlock;

@end
