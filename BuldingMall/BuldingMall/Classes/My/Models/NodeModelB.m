//
//  NodeModelB.m
//  BuldingMall
//
//  Created by noise on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "NodeModelB.h"

@implementation NodeModelB

+(instancetype)initNodeBWithDict:(NSDictionary *)dict
{
    NodeModelB *model = [[self alloc] init];
    
    [model setKeyValues:dict];
    
    return model;
    
}

@end
