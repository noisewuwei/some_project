//
//  TestVC.h
//  MMTabBarView Demo
//
//  Created by zuler on 2022/4/12.
//  Copyright © 2022 Michael Monscheuer. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if __has_feature(modules)
@import MMTabBarView;
#else
#import <MMTabBarView/MMTabBarView.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TestVC : NSViewController<MMTabBarViewDelegate,NSMenuDelegate>

@end

NS_ASSUME_NONNULL_END
