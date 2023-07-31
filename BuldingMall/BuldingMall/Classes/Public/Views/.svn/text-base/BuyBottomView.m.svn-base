//
//  BuyBottomView.m
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BuyBottomView.h"
#import "UpImageDownTextBageButton.h"
#import "ZJTabBarController.h"
@interface BuyBottomView()
{
    UIView *_leftView;
}
@end

@implementation BuyBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       self.barTintColor = [UIColor whiteColor];
      [self buildBottom];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame eventAction:(EventAction)eventAction{
    self = [self initWithFrame:frame];
    self.eventAction = eventAction;
    
    return self;
}

-(void)buildBottom{
    [self buildRightView];
    
    [self buildLeftView:@[@"立即抢购"]];
    
}

-(void)buildRightView{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth*0.3, self.frame.size.height)];
    NSArray *titleArray = @[@"联系客服",@"客服电话"];
    NSArray *imageArray = @[@"btn_kefu3.png",@"btn_phone3.png"];
    
    for (int i=0; i<titleArray.count; i++)
    {
        
        CGFloat x = i*(rightView.frame.size.width/2);
        CGFloat y = 0;
        CGFloat wid = rightView.frame.size.width/2;
        
        UpImageDownTextBageButton *btn = [[UpImageDownTextBageButton alloc] initWithFrame:CGRectMake(x, y, wid, rightView.frame.size.height) ImageName:imageArray[i]];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitleColor:[UIColor colorHexString:@"#666666"] forState:UIControlStateNormal];
        //201 ActionStyleService 202 ActionStylePhone
        btn.tag = 201 + i;
        [btn addTarget:self action:@selector(actionSomeThings:) forControlEvents:UIControlEventTouchUpInside];
        
        [rightView addSubview:btn];
    }
    
    [self addSubview:rightView];
}

-(void)buildLeftView:(NSArray*)titleArray{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(zScreenWidth*0.3, 0, zScreenWidth*0.7, self.frame.size.height)];
    }
    
    for (int i=0; i<titleArray.count; i++)
    {
        
        CGFloat x = i*(_leftView.frame.size.width/2);
        CGFloat y = 0;
        CGFloat wid = _leftView.frame.size.width/titleArray.count;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, wid, _leftView.frame.size.height);
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        //203 ActionStyleFullPayment 204 ActionStylePrepare
        btn.tag = 203 + i;
        if (titleArray.count>1) {
            btn.tag = 203 + titleArray.count-1 - i;
        }
        
        //一元夺宝 205 ActionStyleSnatch1
        if ([self.panicBuyingType isEqual:@2] && i == 0) {
            btn.tag = ActionStyleSnatch1;
        }else if ([self.panicBuyingType isEqual:@3] && i == 0){
            btn.tag = ActionStylePayment1;
        }
        
        if ([_panicBuyingType  isEqual: @4]) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor colorHexString:@"#cccccc"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorHexString:@"#e5e5e5"];
            
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
        }
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        
        if (titleArray.count > 1) {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            if (i==0) {
                btn.backgroundColor = [UIColor orangeColor];
            }
        }
        [btn addTarget:self action:@selector(actionSomeThings:) forControlEvents:UIControlEventTouchUpInside];
        
        [_leftView addSubview:btn];
    }

    [self addSubview:_leftView];
}

-(void)setPanicBuyingType:(NSNumber *)panicBuyingType{
    _panicBuyingType = panicBuyingType;
    
    NSArray *titleArray;
    if ([_panicBuyingType  isEqual: @0]) {
        titleArray = @[@"10元预抢",@"全款秒杀"];
    }
    else if ([_panicBuyingType  isEqual: @1]||[_panicBuyingType  isEqual: @3]) {
        titleArray = @[@"立即抢购"];
    }else if ([_panicBuyingType  isEqual: @2]){
        
        titleArray = @[@"1元夺宝",@"全款购买"];
    }
    else{
        titleArray = @[@"即将开抢"];
    }
    
    for (UIView *view in _leftView.subviews) {
        [view removeFromSuperview];
    }
    
    [self buildLeftView:titleArray];
}

-(void)actionSomeThings:(UIButton*)sender{
    self.actionStyle = sender.tag;
    if (self.eventAction) {
        self.eventAction(self.actionStyle);
    }
}

@end
