//
//  YNCollectionViewCell.h
//  TableView_11
//
//  Created by zfy on 2016/10/12.
//  Copyright © 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *hidView;
@property (weak, nonatomic) IBOutlet UILabel *pilab;

@end
