//
//  PerViewController.h
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "BaseViewController.h"
#import "Follower.h"

@interface PerViewController : BaseViewController<FollowerDelegate>

@property (nonatomic, strong) Follower *follower;

@end
