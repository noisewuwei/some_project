//
//  EventItemModel.h
//  Owner
//
//  Created by zfy on 16/6/22.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventItemModel : NSObject
@property (nonatomic,copy)NSString *status_count;
@property(nonatomic,copy)NSString *status_id;
@property(nonatomic,copy)NSString *status_name;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end
