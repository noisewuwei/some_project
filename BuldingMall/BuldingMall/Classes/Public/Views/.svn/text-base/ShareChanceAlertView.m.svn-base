//
//  ShareChanceAlertView.m
//  BuldingMall
//
//  Created by Jion on 2016/10/28.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ShareChanceAlertView.h"

@interface ShareChanceAlertView ()
{
    CGRect rect;
}
@property (nonatomic, strong) UIControl *controlForDismiss;
@property(nonatomic, strong)UIButton *dismissBtn;

@property(nonatomic,strong)UILabel      *topLabel;
@property(nonatomic,strong)UIImageView *topImageView;

@property(nonatomic,strong)UILabel  *shareLabel;
@property(nonatomic,strong)UILabel  *bigTextLabel;
@property(nonatomic,strong)UILabel  *smallTextLabel;

@property(nonatomic,strong)UIButton *greenBtn;
@property(nonatomic,strong)UIButton *grayBtn;

@property(nonatomic,copy)ClickEventBlock eventBlock;
@property(nonatomic,assign)ChanceType chanceType;

@end

@implementation ShareChanceAlertView

+(ShareChanceAlertView *)instanceCustomAlert:(ChanceType)chanceType handle:(ClickEventBlock)eventBlock{
    ShareChanceAlertView *alert = [[ShareChanceAlertView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 120, 200)];
    alert.chanceType = chanceType;
    alert.eventBlock = eventBlock;
    
    [alert showInBlur:YES];
    
    return alert;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        rect = frame;
    }
    return self;
}
-(void)setChanceType:(ChanceType)chanceType{
    _chanceType = chanceType;
     [self buildView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect lastRect = self.frame;
    lastRect.size.height = CGRectGetMaxY(self.grayBtn.frame)+20;
    self.frame = lastRect;
}
-(void)buildView{
    if (_chanceType == ChanceTypeDefault) {
        [self addSubview:self.topLabel];
    }else{
        [self addSubview:self.topImageView];
    }
    
    [self addSubview:self.shareLabel];
    
    [self addSubview:self.bigTextLabel];
    [self addSubview:self.smallTextLabel];
    
    [self addSubview:self.greenBtn];
    [self addSubview:self.grayBtn];
    
    [self addSubview:self.dismissBtn];
    if (_chanceType != ChanceTypeDefault) {
        self.shareLabel.hidden = YES;
        
        self.bigTextLabel.text = @"您的三次购买机会已经用完!";
        self.bigTextLabel.textColor = [UIColor blackColor];
        
        self.smallTextLabel.text = @"您还可以";
        
        [self.greenBtn setTitle:@"全款直接买" forState:UIControlStateNormal];
        
        [self.grayBtn setTitle:@"逛逛商城" forState:UIControlStateNormal];
    }
}

#pragma mark --Action
-(void)actionDismissClick:(UIButton*)sender{
    [self animatedOut];
}

-(void)onEventAction:(UIButton*)sender{
    [self animatedOut];
    EventType eventType = EventTypeUnKnow;
    if (sender.tag == 2010 && self.chanceType == ChanceTypeDefault) {
        eventType = EventTypeShare;
    }else if (sender.tag == 2020 && self.chanceType == ChanceTypeDefault){
        eventType = EventTypeGoBuy;
    }else if (sender.tag == 2010 && self.chanceType == ChanceTypeNone){
        eventType = EventTypeGoBuy;
    }else if (sender.tag == 2020 && self.chanceType == ChanceTypeNone){
        eventType = EventTypeGoBack;
    }
   
    if (self.eventBlock) {
        self.eventBlock(eventType);
    }
}

#pragma mark -- getter
-(UILabel*)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 55)];
        _topLabel.backgroundColor = kGlobalColor;
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.font = [UIFont boldSystemFontOfSize:16.0];
         _topLabel.text = @"您的购买机会用完了!";
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_topLabel.bounds      byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft    cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _topLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        _topLabel.layer.mask = maskLayer;
    }
    
    return _topLabel;
}

-(UIImageView*)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.frame = CGRectMake(5, 8, self.frame.size.width - 10, 90);
        _topImageView.contentMode = UIViewContentModeCenter;
        _topImageView.image = [UIImage imageNamed:@"btn_katong"];
    }
    return _topImageView;
}
-(UILabel*)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        
        if (_chanceType == ChanceTypeDefault) {
            _shareLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topLabel.frame)+30, rect.size.width, 20);
        }else{
           _shareLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame), rect.size.width, 0);
        }
        
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.textColor = [UIColor blackColor];
        _shareLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _shareLabel.text = @"分享好友，成功购买";
 
    }
    return _shareLabel;
}

-(UILabel*)bigTextLabel{
    if (!_bigTextLabel) {
        _bigTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareLabel.frame)+10, rect.size.width, 20)];
        _bigTextLabel.textAlignment = NSTextAlignmentCenter;
        _bigTextLabel.textColor = kGlobalColor;
        _bigTextLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _bigTextLabel.text = @"即可再次获得购买机会";
    }
    return _bigTextLabel;
}
-(UILabel*)smallTextLabel{
    if (!_smallTextLabel) {
        _smallTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bigTextLabel.frame)+10, rect.size.width, 20)];
        _smallTextLabel.textAlignment = NSTextAlignmentCenter;
        _smallTextLabel.textColor = [UIColor colorHexString:@"#333333"];
        _smallTextLabel.font = [UIFont systemFontOfSize:12];
        _smallTextLabel.text = @"(最多3次机会)";
    }
    return _smallTextLabel;
}

-(UIButton*)greenBtn{
    if (!_greenBtn) {
        _greenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _greenBtn.frame = CGRectMake(15, CGRectGetMaxY(self.smallTextLabel.frame)+15, rect.size.width - 2*15, 35);
        _greenBtn.tag = 2010;
        [_greenBtn setBackgroundColor:kGlobalColor];
        _greenBtn.layer.cornerRadius = 4.0;
        _greenBtn.layer.masksToBounds = YES;
        [_greenBtn setTitle:@"立即分享" forState:UIControlStateNormal];
        [_greenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _greenBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        [_greenBtn addTarget:self action:@selector(onEventAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _greenBtn;
}

-(UIButton*)grayBtn{
    if (!_grayBtn) {
        _grayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _grayBtn.frame = CGRectMake(40, CGRectGetMaxY(self.greenBtn.frame)+10, rect.size.width - 2*40, 30);
        _grayBtn.tag = 2020;
        [_grayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _grayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_grayBtn addTarget:self action:@selector(onEventAction:) forControlEvents:UIControlEventTouchUpInside];
        [_grayBtn setTitle:@"土豪直接买" forState:UIControlStateNormal];
    }
    
    return _grayBtn;
}

-(UIButton*)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(self.frame.size.width-30, -40, 40, 40);
        [_dismissBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(actionDismissClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

#pragma mark -- 添加蒙版
-(void)showInBlur:(BOOL)blur
{
    if (nil == _controlForDismiss && blur)
    {
        _controlForDismiss = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIWindow *keywindow = [[UIApplication sharedApplication]keyWindow];
    if (_controlForDismiss)
    {
        [keywindow addSubview:_controlForDismiss];
    }
    
    [keywindow addSubview:self];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height/2.0);
    
    [self animatedIn];
    
    
}
#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
    
    }];
    
}
- (void)touchForDismissSelf:(id)sender
{
    [self animatedOut];
}
- (void)animatedOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
        _controlForDismiss.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (_controlForDismiss)
            {
                [_controlForDismiss removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];
}



@end
