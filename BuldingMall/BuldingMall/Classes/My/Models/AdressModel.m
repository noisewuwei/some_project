//
//  AdressModel.m
//  BuldingMall
//
//  Created by noise on 16/9/18.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "AdressModel.h"

@implementation AdressModel

+(instancetype)initAdressWithDict:(NSDictionary *)dict
{
    AdressModel *model = [[self alloc]init];
    
    if (![[dict objectForKey:@"id"] isEqual:[NSNull null]])
    {
        model.Id = [[dict objectForKey:@"id"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    
    [model setKeyValues:dict];
    
    return model;
    
}

@end
