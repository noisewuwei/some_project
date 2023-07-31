//
//  OrderListViewCell.h
//  BuldingMall
//
//  Created by zfy on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
#import "OderListController.h"

typedef void(^DelCellBack)();

@interface OrderListViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIButton *picBtn;//图片按钮
@property (weak, nonatomic) IBOutlet UIImageView *picImg;

@property (weak, nonatomic) IBOutlet UIButton *seeListBtn;//查看按钮
@property (weak, nonatomic) IBOutlet UIView *DelView;//删除按钮放的view
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;//下单时间
@property (weak, nonatomic) IBOutlet UILabel *bianHaoLab;
@property (weak, nonatomic) IBOutlet UILabel *status_name;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;


@property (weak, nonatomic) IBOutlet UIView *dingview;
@property (weak, nonatomic) IBOutlet UIButton *dingbtnn;

//@property (nonatomic,copy)OderListController *nav;
@property (nonatomic,strong)UINavigationController *nav;


@property (nonatomic,copy)DelCellBack   delCellBack;
-(void)addTheValue:(ListModel *)listModel;

@end
