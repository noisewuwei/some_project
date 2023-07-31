//
//  BannerModel.h
//  BuldingMall
//
//  Created by zfy on 2016/10/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
/*
 类型
 */
@property(nonatomic,copy)NSString  *type;
/*
 网页标题
 

 
 */

@property (nonatomic,strong)NSString *title;

@property(nonatomic,copy)NSString  *target;
/*
 图片
 */
@property(nonatomic,copy)NSString  *img;
/*
 商品点击指向链接
 */
@property(nonatomic,copy)NSString  *link;

+(instancetype)initBannerListWithDict:(NSDictionary *)dict;
@end
