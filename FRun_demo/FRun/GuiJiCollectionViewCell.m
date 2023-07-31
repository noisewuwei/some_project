//
//  GuiJiCollectionViewCell.m
//  FRun
//
//  Created by noise on 2016/11/14.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "GuiJiCollectionViewCell.h"
#import "Define.h"
@implementation GuiJiCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _picImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (zScreenWidth-6)/3, 150)];
//        _picImg.contentMode = UIViewContentModeCenter;
        [self addSubview:_picImg];
    }
    return self;
}

@end
