//
//  MetricView.m
//  Follower
//
//  Created by noise on 2016/11/8.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "MetricView.h"
#import "UIColor+HexString.h"
#import "Define.h"

@implementation MetricView

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color {
    self = [super init];

    self.layer.cornerRadius = 7.0;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 1.0;

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(TScreenWidth/2-10, TScreenWidth-25, 20, 20)];
    self.iconImageView.image = image;
    [self addSubview:self.iconImageView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, TScreenWidth-20, 20)];
    self.titleLabel.text = [title uppercaseString];
    self.titleLabel.textColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.titleLabel];

    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, TScreenWidth, 20)];
    self.valueLabel.textColor = BtnColor;
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.valueLabel];
    
    return self;
}


@end
