//
//  BuildOrderModel.h
//  BuldingMall
//
//  Created by Jion on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdressModel.h"
@class ClassificationModel;
@interface BuildOrderModel : NSObject

//订单表编号
@property(nonatomic,copy)NSString  *order_id;
//订单编号
@property(nonatomic,copy)NSString  *order_no;
//订单类型, 0-普通订单, 1-10元预购购买, 2-10元预购使用, 3-当期秒杀, 4-当期秒杀并使用10元预购, 5-10元预抢, 6-10元预抢生成的订单, 7-往期秒杀, 8-触摸屏，9-商家触摸屏，10-自营触摸屏,11-一元换购,12-扫码支付,13-建材馆录入订单
@property(nonatomic,copy)NSString  *order_type;
//商品主图
@property(nonatomic,copy)NSString  *good_image;
//商品总价
@property(nonatomic,copy)NSString  *total_fee;
//红包抵扣
@property(nonatomic,copy)NSString  *available_red_packet;
//抵用券抵扣
@property(nonatomic,copy)NSString  *voucher;
//实付金额
@property(nonatomic,copy)NSString  *actual_fee;
//收货地址
@property(nonatomic,strong)AdressModel  *address;
//商品信息
@property(nonatomic,strong)NSArray<ClassificationModel*>  *good_items;

@end

#pragma mark --ClassificationModel
//商品分类
@interface ClassificationModel : NSObject
//商品id
@property(nonatomic,copy) NSString *good_id;
//商品名
@property(nonatomic,copy) NSString *good_name;
//分类id
@property(nonatomic,copy) NSString *classification_id;
//商品主图
@property(nonatomic,copy) NSString *good_image;
//规格型号
@property(nonatomic,copy) NSString *classification_name;
// 产品数量
@property(nonatomic,copy) NSString *classification_num;
//产品原价
@property(nonatomic,copy) NSString *classification_original_cost;
// 产品价格
@property(nonatomic,copy) NSString *sale_price;
//分享优惠
@property(nonatomic,copy) NSString *classification_share_offer;
//商品可用红包
@property(nonatomic,copy) NSString *available_red_packet;

@end
