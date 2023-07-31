//
//  TypeRemindButton.m
//  Owner
//
//  Created by zfy on 16/6/27.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "TypeRemindButton.h"
@interface TypeRemindButton()
{
    CGRect _frame;
    
}
@end

@implementation TypeRemindButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _frame = frame;
        
    }
    
    return self;
    
}

-(void)setRemindImage:(UIImageView *)remindImage
{
    if (!_remindImage)
    {
        _remindLable = [[UILabel alloc]init];
        
    }
    
    [_remindImage setImage:[UIImage imageNamed:@"新提醒@2x.png"]];
    _remindImage.frame = CGRectMake(CGRectGetMaxX(_frame)-9, CGRectGetMinY(_frame), 9, 9);
    _remindImage.userInteractionEnabled = YES;
    [self addSubview:_remindImage];
    
}


- (void)setRemindLable:(UILabel *)remindLable{
    if (!_remindLable) {
        _remindLable = [[UILabel alloc] init];
    }
    _remindLable.frame = CGRectMake(CGRectGetMaxX(_frame)-_frame.size.width/2+20, CGRectGetMinY(_frame)+2, 0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        _remindLable.frame =CGRectMake(CGRectGetMaxX(_frame)-_frame.size.width/2+20, CGRectGetMinY(_frame)+2, 20, 20);
    } completion:^(BOOL finished) {
        _remindLable.layer.cornerRadius = 10.0;
        _remindLable.clipsToBounds  =YES;
    }];
    _remindLable.userInteractionEnabled = YES;
    
    _remindLable.backgroundColor = kGlobalColor;
    _remindLable.textColor = [UIColor whiteColor];
    _remindLable.textAlignment = NSTextAlignmentCenter;
    _remindLable.font = [UIFont boldSystemFontOfSize:12];
    _remindLable.hidden = YES;
    [self addSubview:_remindLable];
    
}
-(id)initWithCustumFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self custum:frame];
    }
    return self;
}

-(void)custum:(CGRect)frame
{
    self.frame = frame;
    _badge = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([UIImage imageNamed:@"消息数量@2x.png"])
    {
        _badge.frame = CGRectMake(frame.size.width-20, 2, 22, 22);
        [_badge setBackgroundImage:[UIImage imageNamed:@"消息数量@2x.png"] forState:UIControlStateNormal];
        _badge.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
    }
    else
    {
       _badge.frame = CGRectMake(frame.size.width-16, 2, 18, 18);
//        _badge.frame = CGRectMake(frame.size.width-16, 2, 30, 18);
        _badge.layer.cornerRadius = 9.0;
        _badge.clipsToBounds = YES;
        _badge.layer.borderColor = [[UIColor whiteColor]CGColor];
        _badge.layer.borderWidth = 1.0f;
        _badge.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        _badge.backgroundColor = [UIColor redColor];
        
        
    }
    
    _badge.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^{
        _badge.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [_badge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _badge.hidden = YES;
    [self addSubview:_badge];
    
}

-(void)setText:(NSString *)text
{
    _text = text;
    if ([text integerValue]>0)
    {
        _badge.hidden = NO;
        [_badge setTitle:text forState:UIControlStateNormal];
        if ([text integerValue]>99)
        {
            [_badge setTitle:@"99" forState:UIControlStateNormal];
            
        }
        if (text.length >1 && ![UIImage imageNamed:@"消息数量@2x.png"])
        {
            _badge.frame = CGRectMake(self.frame.size.width-16, 2, 25, 18);
            
        }
    }
    else
    {
        _badge.hidden = YES;
        
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
