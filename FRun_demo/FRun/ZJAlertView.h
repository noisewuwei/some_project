//
//  ZJAlertView.h
//  BusinessManage
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJAlertView : UIView
+ (id)alertViewInView:(UIView *)aSuperview getMessage:(NSString *)message kind:(BOOL)_kind x:(float)_x y:(float)_y;
- (void)removeView;
@end
