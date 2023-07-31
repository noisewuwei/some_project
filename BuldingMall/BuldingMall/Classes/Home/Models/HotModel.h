//
//  HotModel.h
//  BuldingMall
//
//  Created by zfy on 2016/10/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject
/*
 商品ID
 */
@property(nonatomic,copy)NSString  *ID;
/*
 商品名
 */
@property(nonatomic,copy)NSString  *name;
/*
 促销价
 */
@property(nonatomic,copy)NSString  *sale_price;

@property(nonatomic,copy)NSString *seckill_price;
/*
 总销量
 */
@property(nonatomic,copy)NSString  *total_sales;
/*
 图片
 */
@property(nonatomic,copy)NSString  *image;
/*
 商品点击指向链接
 */
@property(nonatomic,copy)NSString  *url;

+(instancetype)initHotListWithDict:(NSDictionary *)dict;

@end
