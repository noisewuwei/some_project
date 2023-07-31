//
//  PaymentCell.h
//  BuldingMall
//
//  Created by Jion on 16/9/19.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PaymentWay) {
    PaymentWayWXPay  = 0,
    PaymentWayZhiFuBaoPay,
};
@class PaymentModel;
@interface PaymentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+(instancetype)shareCellWithTable:(UITableView*)tableView model:(PaymentModel*)model;
@end

@interface PaymentModel :NSObject

@property(nonatomic,copy)NSString *imagName;
@property(nonatomic,copy)NSString  *titleText;

@end
