//
//  ChooseAddressView.m
//  BuldingMall
//
//  Created by zfy on 16/9/19.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ChooseAddressView.h"

@implementation ChooseAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(ChooseAddressView *)instanceNewAddressView
{
    
    NSArray *newAddressArr = [[NSBundle mainBundle]loadNibNamed:@"ChooseAddressView" owner:nil options:nil];
    ChooseAddressView *chooseView = [newAddressArr objectAtIndex:0];
//    chooseView.CanCelBtn.layer.borderWidth = 0.5;
//    chooseView.CanCelBtn.layer.borderColor = [UIColor colorHexString:@"#00c24f"].CGColor;
//    chooseView.OkBtn.layer.borderWidth = 0.5;
//    chooseView.OkBtn.layer.borderColor = [UIColor colorHexString:@"#00c24f"].CGColor;
//
//     chooseView.frame = CGRectMake(0, zScreenHeight-200, zScreenWidth, 200);
    
    
    return chooseView;
    
}
- (void)showViewInControl
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
    
    if (nil == _controlForDismiss)
    {
        _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
//       [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (_controlForDismiss)
    {
        [keywindow addSubview:_controlForDismiss];
    }
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f-30);
    
    
}

//手势
- (void)handleTap:(UITapGestureRecognizer*)tap
{
    [self endEditing:YES];
    
}

//取消点击按钮的触发事件
- (IBAction)CanCelClick:(UIButton *)sender {
    
     [self animatedOut];
    
}
- (void)animatedOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
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

//确定按钮的触发事件
- (IBAction)OkBtnClick:(UIButton *)sender {
    
      [self animatedOut];
}


@end
