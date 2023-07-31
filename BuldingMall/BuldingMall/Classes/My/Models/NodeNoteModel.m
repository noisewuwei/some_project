//
//  NodeNoteModel.m
//  BuldingMall
//
//  Created by noise on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "NodeNoteModel.h"

@implementation NodeNoteModel

+(instancetype)initNodeNoteWithDict:(NSDictionary *)dict
{
    NodeNoteModel *model = [[self alloc] init];
    
    [model setKeyValues:dict];
    
    return model;
    
}

@end
