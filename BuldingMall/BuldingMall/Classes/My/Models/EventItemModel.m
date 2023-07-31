//
//  EventItemModel.m
//  Owner
//
//  Created by zfy on 16/6/22.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "EventItemModel.h"

@implementation EventItemModel

+(instancetype)initWithDict:(NSDictionary *)dict
{
    EventItemModel *model = [[self alloc] init];
    
    [model setKeyValues:dict];
    
    return model;
    
    
}

@end
