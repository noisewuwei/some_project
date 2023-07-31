//
//  AddressAddModel.m
//  BuldingMall
//
//  Created by zfy on 16/9/20.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "AddressAddModel.h"

@implementation AddressAddModel
+(instancetype)initWithDict:(NSDictionary *)dict
{
    AddressAddModel *model = [[self alloc] init];
    
    [model setKeyValues:dict];
    
    return model;

}
@end
