//
//  BuyBottomView.h
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ActionStyle) {
    ActionStyleService = 201,   //联系客服
    ActionStylePhone,         //客服电话
    
    ActionStyleFullPayment,  //全款秒杀，全款购买,立即抢购
    ActionStylePrepare,      //10元预抢，
    ActionStylePayment1,    //一元抢购
    ActionStyleSnatch1,      //一元夺宝
    ActionStyleNone,    //不可点击
};


#import <UIKit/UIKit.h>

typedef void(^EventAction)(ActionStyle index);
@interface BuyBottomView : UIToolbar
@property(nonatomic,copy)EventAction eventAction;

@property(nonatomic,assign)ActionStyle actionStyle;

/*
 购买类型，
 0显示预抢和全款秒杀,
 1显示立即抢购，（普通商品的）
 2显示一元夺宝和全款购买
 3.显示立即抢购（一元换购的）
 4.显示立即抢购 但不可点击
 */
@property (nonatomic,assign)NSNumber  *panicBuyingType;


-(instancetype)initWithFrame:(CGRect)frame eventAction:(EventAction)eventAction;

@end
