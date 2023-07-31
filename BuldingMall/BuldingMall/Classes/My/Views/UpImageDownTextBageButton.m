//
//  UpImageDownTextBageButton.m
//  MyPods
//
//  Created by Jion on 16/8/22.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "UpImageDownTextBageButton.h"
@interface UpImageDownTextBageButton ()
@property(nonatomic,copy)ActionClick actionClick;
@property(nonatomic,weak)UIButton  *badgeBtn;

@end
@implementation UpImageDownTextBageButton

-(UIButton*)badgeBtn{
    if (!_badgeBtn) {
        UIButton *badgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        badgeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        badgeBtn.bounds = CGRectMake(0, 0, 18, 18);
        
        if ([UIImage imageNamed:@"btn_red_news1.png"]) {
            badgeBtn.adjustsImageWhenHighlighted = NO;
            badgeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [badgeBtn setBackgroundImage:[UIImage imageNamed:@"btn_red_news1.png"] forState:UIControlStateNormal];
        }else{
            badgeBtn.enabled = NO;
            badgeBtn.layer.cornerRadius = badgeBtn.bounds.size.height/2;
            badgeBtn.layer.borderWidth = 1.0;
            badgeBtn.layer.borderColor = [[UIColor redColor] CGColor];
            [badgeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        badgeBtn.hidden = YES;
        [self addSubview:badgeBtn];
        
        _badgeBtn = badgeBtn;
    }
    return _badgeBtn;
}

-(void)targetActon:(UIButton*)sender{
   __weak typeof (self)weakSelf = self;
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (self.actionClick) {
            self.actionClick(weakSelf);
        }

    }];
    
}

-(void)addTarget:(id)target actionBlock:(ActionClick)action {
    self.actionClick = action;
    [self addTarget:self action:@selector(targetActon:) forControlEvents:UIControlEventTouchUpInside];
    [self.badgeBtn addTarget:self action:@selector(targetActon:) forControlEvents:UIControlEventTouchUpInside];
}

-(instancetype)init{
    if (self = [super init]) {
        [self loadBase];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame ImageName:(NSString*)imageName{
    self = [self initWithFrame:frame Title:nil ImageName:imageName Badge:nil];
    if (self) {
        
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString*)title ImageName:(NSString*)imageName Badge:(NSString*)badge {
    if (self = [super initWithFrame:frame]) {
       [self loadBase];
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (imageName) {
            [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }
        self.badgeValue = badge;
    }
    
    return self;
}

-(void)loadBase{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeCenter;
    
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    if (badgeValue && [badgeValue integerValue] > 0) {
        self.badgeBtn.hidden = NO;
        [self.badgeBtn setTitle:badgeValue forState:UIControlStateNormal];
        self.badgeBtn.transform = CGAffineTransformMakeScale(0.05, 0.05);
        [UIView animateWithDuration:0.5 animations:^{
            self.badgeBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }else{
      self.badgeBtn.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0,self.frame.size.height - 15, self.frame.size.width, self.titleLabel.frame.size.height);
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 15);
    self.badgeBtn.frame = CGRectMake(self.frame.size.width/2+2, self.frame.size.height/2-self.badgeBtn.frame.size.height*1.5, self.badgeBtn.frame.size.width, self.badgeBtn.frame.size.height);
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
