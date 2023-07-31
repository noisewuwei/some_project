//
//  GoodsModel.h
//  BuldingMall
//
//  Created by Jion on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
/*
 分类信息的集合
 */
@property(nonatomic,strong)NSArray *classifications;
/*
 商品id
 */
@property(nonatomic,copy)NSString  *goods_id;
/*
  换购活动id
 */
@property(nonatomic,copy)NSString *redemption_id;
/*
 商品主图
 */
@property(nonatomic,copy)NSString  *goods_image;

@end

/*******商品分类模型**********/
@interface GoodsClassificationsModel : NSObject
/*
 当前分类ID
 */
@property(nonatomic,copy)NSString  *classifications_id;
/*
 分类名
 */
@property(nonatomic,copy)NSString  *name;
/*
 分类剩余数量
 */
@property(nonatomic,copy)NSString  *num;
/*
 分类秒杀价
 */
@property(nonatomic,copy)NSString  *seckill_price;
/*
 分类补贴
 */
@property(nonatomic,copy)NSString  *subsidy;
/*
 购买数量
 */
@property(nonatomic,copy)NSString  *buyNumber;

@end

