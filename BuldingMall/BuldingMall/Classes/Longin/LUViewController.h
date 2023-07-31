//
//  LUViewController.h
//  BuldingMall
//
//  Created by noise on 2016/10/26.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();


@interface LUViewController : BaseViewController

@property (nonatomic,strong) NSMutableDictionary *dic;
@property(nonatomic,copy)CallBlock TabbarcallBlock;

@end
