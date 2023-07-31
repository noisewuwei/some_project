//
//  NodeModel.m
//  BuldingMall
//
//  Created by noise on 16/9/23.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "NodeModel.h"

@implementation NodeModel

+(instancetype)initNodeWithDict:(NSDictionary *)dict
{
    NodeModel *model = [[self alloc] init];
    
    [model setKeyValues:dict];
    
    return model;
    
}

@end
