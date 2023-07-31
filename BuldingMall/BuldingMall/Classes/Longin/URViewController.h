//
//  URViewController.h
//  BuldingMall
//
//  Created by noise on 2016/10/28.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();

@interface URViewController : BaseViewController
@property (nonatomic,strong) NSMutableDictionary *dic;

@property(nonatomic,copy)CallBlock TabbarcallBlock;

@end
