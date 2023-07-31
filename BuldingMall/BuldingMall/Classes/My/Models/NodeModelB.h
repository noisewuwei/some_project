//
//  NodeModelB.h
//  BuldingMall
//
//  Created by noise on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModelB : NSObject

@property (nonatomic,copy) NSString *created;//
@property (nonatomic,copy) NSString *first_node_set_time;//
@property (nonatomic,copy) NSString *first_node;
@property (nonatomic,copy) NSString *goods_id;//
@property (nonatomic,copy) NSArray *info;//
@property (nonatomic,copy) NSString *fllow_time;

+(instancetype)initNodeBWithDict:(NSDictionary *)dict;

@end
