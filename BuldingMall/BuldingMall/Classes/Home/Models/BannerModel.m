//
//  BannerModel.m
//  BuldingMall
//
//  Created by zfy on 2016/10/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
+(instancetype)initBannerListWithDict:(NSDictionary *)dict
{
    BannerModel *model = [[self alloc]init];
    
    [model setKeyValues:dict];
    
    return model;

}
@end
