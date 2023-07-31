//
//  BuildOrderModel.m
//  BuldingMall
//
//  Created by Jion on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BuildOrderModel.h"

@interface BuildOrderModel()
@property(nonatomic,strong)NSDictionary  *user_address;

@end
@implementation BuildOrderModel

-(AdressModel*)address{
    AdressModel *model = [AdressModel objectWithKeyValues:self.user_address];
    
    return model;
}

-(void)setGood_items:(NSArray *)good_items{
    _good_items = good_items;
    NSMutableArray *paredArray = [NSMutableArray array];
    [_good_items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)obj;
            ClassificationModel *model = [ClassificationModel objectWithKeyValues:dic];
            [paredArray addObject:model];
        }
        
    }];
    _good_items = [NSArray arrayWithArray:paredArray];

}

@end

#pragma mark -- ClassificationModel
@implementation ClassificationModel

@end


