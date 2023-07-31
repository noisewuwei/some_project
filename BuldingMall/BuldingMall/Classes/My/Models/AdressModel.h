//
//  AdressModel.h
//  BuldingMall
//
//  Created by noise on 16/9/18.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdressModel : NSObject

@property(nonatomic,copy) NSString *Id;//地址ID
@property(nonatomic,copy) NSNumber *is_default;//是否默认地址 1:是 0:否
@property(nonatomic,copy) NSString *receive_name;//收货人姓名
@property(nonatomic,copy) NSString *address;//详细地址
@property(nonatomic,copy) NSString *mobile;//联系电话
@property(nonatomic,copy) NSString *province;//省
@property(nonatomic,copy) NSString *province_id;
@property(nonatomic,copy) NSString *city_id;//城市
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *district;//区域
@property(nonatomic,copy) NSString *district_id;




+(instancetype)initAdressWithDict:(NSDictionary *)dict;

@end
