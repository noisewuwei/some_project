//
//  FastLonginController.h
//  BuldingMall
//
//  Created by Jion on 2016/10/24.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^CallBlock)();
@interface FastLonginController : BaseViewController
@property(nonatomic,copy)CallBlock TabbarcallBlock;
@end
