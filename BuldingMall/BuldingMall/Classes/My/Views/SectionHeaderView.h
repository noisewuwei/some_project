//
//  SectionHeaderView.h
//  BuldingMall
//
//  Created by noise on 16/9/21.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,strong) UILabel *seclabel;
@property (nonatomic,strong) UILabel *Tiplabel;
@property (nonatomic,strong) UILabel *Prolabel;
@property (nonatomic,strong) UILabel *timelable;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIImageView *TipView;
@property (nonatomic,strong) UIImageView *ProView;
@property (nonatomic,strong) UIImageView *RightView;
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIButton *bigbutton;

@end
