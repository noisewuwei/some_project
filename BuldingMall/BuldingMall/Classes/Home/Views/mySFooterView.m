//
//  mySFooterView.m
//  colltest
//
//  Created by noise on 2016/10/13.
//  Copyright © 2016年 noise. All rights reserved.
//

#import "mySFooterView.h"

@implementation mySFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.backgroundColor = [UIColor colorHexString:@"f0f0f0"];//f0f0f0
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.bounds.size.width, 35)];
    view1.backgroundColor = [UIColor whiteColor];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 35)];
    [_button setImage:[UIImage imageNamed:@"btn_ckgd.png"] forState:UIControlStateNormal];
    [view1 addSubview:_button];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 150)];
    image.image = [UIImage imageNamed:@"btn_banner4.png"];
    
    
    [self addSubview:image];
    [self addSubview:view1];
}


@end
