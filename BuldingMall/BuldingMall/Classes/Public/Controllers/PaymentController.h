//
//  PaymentController.h
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"

@interface PaymentController : BaseViewController
//订单表id 必填 注意：如果是一元夺宝，该字段传递的值要为一元夺宝的no
@property(nonatomic,strong)NSString  *order_no;
//是否为一元夺宝
@property(nonatomic,assign)BOOL  isOneSnatch;

@end
