//
//  MetricView.h
//  Follower
//
//  Created by noise on 2016/11/8.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetricView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color;

@end
