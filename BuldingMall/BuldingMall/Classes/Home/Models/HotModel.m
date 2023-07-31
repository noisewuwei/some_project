//
//  HotModel.m
//  BuldingMall
//
//  Created by zfy on 2016/10/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel
+(instancetype)initHotListWithDict:(NSDictionary *)dict

{
    HotModel *model = [[self alloc]init];
    
    if (![[dict objectForKey:@"id"] isEqual:[NSNull null]])
    {
        model.ID = [[dict objectForKey:@"id"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    
    [model setKeyValues:dict];
    
    return model;

}


@end
