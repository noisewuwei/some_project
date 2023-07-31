//
//  TypeItemView.h
//  BuldingMall
//
//  Created by zfy on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeRemindButton.h"
@class TypeItemView;
@protocol TypeItemViewDelegate <NSObject>

-(void)itemView:(TypeItemView*)itemView didSelectItem:(TypeRemindButton *)item table:(UITableView *)tableView;


@end

@interface TypeItemView : UIView
@property (nonatomic,weak)id<TypeItemViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *tableArray;
@property(nonatomic,assign)NSInteger   selectIndex;
-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array;
@property (nonatomic,assign)CGRect  scRect;
@end
