//
//  PickerSheetView.h
//  BuldingMall
//
//  Created by Jion on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LonginController.h"
#import "GoodsModel.h"

typedef NS_ENUM(NSUInteger, SheetType) {
    SheetTypeDefault,//立即抢购
    SheetTypeSnatch1,//一元夺宝
    SheetTypeMerit = 3,//全款秒杀
    SheetTypePrepare = 5,//10元预抢
    SheetTypeOldMerit = 7,//往期秒杀
    SheetTypePayment1 = 11,//一元抢购

};

typedef void(^CommitBlock)(id model);
@interface PickerSheetView : UIView
//购买类型 先设置类型再传入数据
/*
 3-当期秒杀
 5-10元预抢
 7-往期秒杀
 11-一元换购
 
 */

@property (nonatomic,assign)SheetType sheetType;
@property(nonatomic,strong)GoodsModel  *goodsModel;
@property(nonatomic,copy)CommitBlock  commitBlock;

+(PickerSheetView *)instancePickerSheetView:(id)delegate;

+(PickerSheetView *)instancePickerSheetView:(id)delegate commitBlock:(CommitBlock)commitBlock;

- (void)animatedOut;

@end
