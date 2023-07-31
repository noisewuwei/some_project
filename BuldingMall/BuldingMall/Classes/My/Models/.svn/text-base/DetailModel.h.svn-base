//
//  DetailModel.h
//  BuldingMall
//
//  Created by noise on 16/9/19.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject


@property(nonatomic,copy) NSString *ex_time;//取消订单剩余时间
@property(nonatomic,copy) NSString *status;//状态文字
@property(nonatomic,copy) NSString *status_id;//0:删除1:待付款2:待发货3:带收货4:待评价5:已取消
@property(nonatomic,copy) NSString *consignee;//收货人姓名
@property(nonatomic,copy) NSString *mobile;//电话
@property(nonatomic,copy) NSString *accept_address;//收货人地址
@property(nonatomic,copy) NSString *no;//订单编号
@property(nonatomic,copy) NSString *createdate;//下单时间
@property(nonatomic,copy) NSString *price;//商品总价
@property(nonatomic,copy) NSString *discount_price;//红包抵扣
@property(nonatomic,copy) NSString *amount;// 实付款
@property(nonatomic,copy) NSString *down_payment;// 定金
@property(nonatomic,copy) NSString *is_virtual_product;

@property(nonatomic,strong) NSArray *goods;//商品列表




+(instancetype)initDetailWithDict:(NSDictionary *)dict;

@end
