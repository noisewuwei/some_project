//
//  ListModel.h
//  BuldingMall
//
//  Created by zfy on 16/9/14.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property(nonatomic,copy)NSString *Id;//订单ID
@property(nonatomic,copy)NSString *createdate;//下单时间
@property(nonatomic,copy)NSString *image;//图片
@property(nonatomic,copy)NSString *no;//订单编号
@property(nonatomic,copy)NSString *status;//订单状态名字
@property(nonatomic,copy)NSString *price;//订单金额
@property(nonatomic,copy)NSString *status_id;//状态的id 要根据这个id来判断以及显示按钮对应不同的字状态
@property(nonatomic,copy)NSString *down_payment;//状态判断 == 0 不显示10元，==10 显示10元
+(instancetype)initListWithDict:(NSDictionary *)dict;
@end
