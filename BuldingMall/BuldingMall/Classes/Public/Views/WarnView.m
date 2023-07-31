//
//  WarnView.m
//  BuldingMall
//
//  Created by Jion on 16/9/14.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "WarnView.h"
@interface WarnView()
@property (nonatomic, strong) UIControl *controlForDismiss;
@property(nonatomic, strong)UIButton *dismissBtn;
@property(nonatomic,strong)UIButton  *nextBtn;

@end

@implementation WarnView

+(WarnView *)sharePickerSheetView:(NextBlock)nextBlock{
    WarnView *sheetView = [[WarnView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 350)];
    [sheetView showInBlur:YES];
    sheetView.nextBlock = nextBlock;
    return sheetView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dismissBtn];
        [self addSubview:self.nextBtn];
        [self buildUIDescribe];
    }
    return self;
}

-(void)buildUIDescribe{
 
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, zScreenWidth - 40, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"10元特权";
    [self addSubview:titleLabel];
    
    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame), zScreenWidth-40, 30)];
    textLabel1.font = [UIFont systemFontOfSize:12];
    textLabel1.text = @"1.可线下实体展厅看样，确认后再付尾款；";
    [self addSubview:textLabel1];
    
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(textLabel1.frame), zScreenWidth-40, 30)];
    textLabel2.font = [UIFont systemFontOfSize:12];
    textLabel2.text = @"2.30天内支付尾款，可享受秒杀价；";
    [self addSubview:textLabel2];
    
    UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(textLabel2.frame), zScreenWidth-40, 30)];
    textLabel3.font = [UIFont systemFontOfSize:12];
    textLabel3.text = @"3.超时未支付尾款自动取消订单，10元定金自动退换！";
    [self addSubview:textLabel3];
    
    UILabel *subTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(textLabel3.frame)+5, zScreenWidth-40, 30)];
    subTitle1.font = [UIFont boldSystemFontOfSize:14];
    subTitle1.text = @"线下展厅:";
    [self addSubview:subTitle1];
    
    UILabel *textLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(subTitle1.frame), zScreenWidth-40, 30)];
    textLabel4.font = [UIFont systemFontOfSize:12];
    textLabel4.text = @"优居客建材家居特卖馆 闵行区 七莘路200号";
    [self addSubview:textLabel4];
    
    UILabel *subTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(textLabel4.frame)+5, zScreenWidth-40, 30)];
    subTitle2.font = [UIFont boldSystemFontOfSize:14];
    subTitle2.text = @"请注意:";
    [self addSubview:subTitle2];
    
    UILabel *textLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(subTitle2.frame), zScreenWidth-40, 30)];
    textLabel5.font = [UIFont systemFontOfSize:12];
    textLabel5.text = @"10元预抢用户发货时间为15个工作日内";
    [self addSubview:textLabel5];
}

-(UIButton*)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(self.frame.size.width-30, 10, 20, 20);
        [_dismissBtn setImage:[UIImage imageNamed:@"btn_del1"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(actionDismissClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}
-(UIButton*)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(0, self.frame.size.height - 45, self.frame.size.width, 45);
        _nextBtn.backgroundColor = [UIColor colorHexString:@"#ff0033"];
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextActionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}


-(void)actionDismissClick:(UIButton*)sender{
    [self animatedOut];
}
-(void)nextActionClick:(UIButton*)sender{
    
    if (self.nextBlock) {
        self.nextBlock();
    }

    if (_controlForDismiss) {
        [_controlForDismiss removeFromSuperview];
    }
    [self removeFromSuperview];
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
    
    self.frame = CGRectMake(0, zScreenHeight, zScreenWidth, self.bounds.size.height);
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, zScreenHeight-self.bounds.size.height, zScreenWidth, self.bounds.size.height);
    }];
    [keywindow addSubview:self];
    
}
#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)touchForDismissSelf:(id)sender
{
    [self animatedOut];
}
- (void)animatedOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.frame = CGRectMake(0, zScreenHeight, zScreenWidth, self.bounds.size.height);
        self.alpha = 0.0;
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
