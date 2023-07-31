//
//  GoodsModel.m
//  BuldingMall
//
//  Created by Jion on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
-(void)setClassifications:(NSArray *)classifications{
    _classifications = classifications;
    NSMutableArray *paredArray = [NSMutableArray array];
    [_classifications enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)obj;
            GoodsClassificationsModel *model = [GoodsClassificationsModel objectWithKeyValues:dic];
            [paredArray addObject:model];
        }
        
    }];

    _classifications = [NSArray arrayWithArray:paredArray];
}

@end

/*******商品分类模型**********/
@implementation GoodsClassificationsModel

@end
