//
//  ShareChanceAlertView.h
//  BuldingMall
//
//  Created by Jion on 2016/10/28.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ChanceType) {
    ChanceTypeDefault,//分享获得购买机会
    ChanceTypeNone, //没有购买机会了
    
};
typedef NS_ENUM(NSUInteger, EventType) {
    EventTypeUnKnow, //不知道的类型
    EventTypeShare,//分享
    EventTypeGoBuy, //购买
    EventTypeGoBack, //返回
    
};
typedef void(^ClickEventBlock)(EventType eventType);
@interface ShareChanceAlertView : UIView

+(ShareChanceAlertView *)instanceCustomAlert:(ChanceType)chanceType handle:(ClickEventBlock)eventBlock;

@end
