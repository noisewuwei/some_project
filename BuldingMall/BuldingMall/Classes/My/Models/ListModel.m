//
//  ListModel.m
//  BuldingMall
//
//  Created by zfy on 16/9/14.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

+(instancetype)initListWithDict:(NSDictionary *)dict
{
    ListModel *model = [[self alloc]init];
    
    if (![[dict objectForKey:@"id"] isEqual:[NSNull null]])
    {
        model.Id = [[dict objectForKey:@"id"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    
    [model setKeyValues:dict];
    
    return model;
    
}

@end
