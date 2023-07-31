//
//  DetailGoodsModel.h
//  BuldingMall
//
//  Created by noise on 16/9/19.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailGoodsModel : NSObject

@property(nonatomic,copy) NSString *name;//商品名
@property(nonatomic,copy) NSString *classification_name;//型号
@property(nonatomic,copy) NSString *image;// 商品图片
@property(nonatomic,copy) NSString *gid;//商品ID
@property(nonatomic,copy) NSString *good_price;
@property(nonatomic,copy) NSString *original_cost;
@property(nonatomic,copy) NSString *num;

+(instancetype)initDetailGoodsWithDict:(NSDictionary *)dict;

@end
