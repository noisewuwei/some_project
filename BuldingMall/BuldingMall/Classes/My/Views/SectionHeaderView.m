//
//  SectionHeaderView.m
//  BuldingMall
//
//  Created by noise on 16/9/21.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView ()




@end

static NSString *const headerID = @"headerID";


@implementation SectionHeaderView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    SectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    
    if (!headerView) {
        headerView = [[SectionHeaderView alloc]initWithReuseIdentifier:headerID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self customUI];
    }
    
    return self;
}

- (void)customUI

{
    _seclabel = [[UILabel alloc]initWithFrame:CGRectMake(43, 18, 35, 15)];
    _seclabel.font = [UIFont systemFontOfSize:15];
    _seclabel.textColor = [UIColor colorHexString:@"333333"];
    [self.contentView addSubview:_seclabel];
    _timelable = [[UILabel alloc]initWithFrame:CGRectMake(43, 40, zScreenWidth - 50, 12)];
    _timelable.font = [UIFont systemFontOfSize:12];
    _timelable.textColor = [UIColor colorHexString:@"808080"];
    _timelable.text = @"2016-04-21";
    [self.contentView addSubview:_timelable];
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 29.5, 12, 12)];
//    _imgView.image = [UIImage imageNamed:@"btn_wxz.png"];
    [self.contentView addSubview:_imgView];
    
    
//    _TipView = [[UIImageView alloc]initWithFrame:CGRectMake(43+35+11, 17, 44, 15)];
//    _TipView.image = [UIImage imageNamed:@"btn_bq1.png"];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(43+35+11, 17, 44, 15)];
    [_button setBackgroundImage:[UIImage imageNamed:@"btn_bq1.png"] forState:UIControlStateNormal];
//    _button.userInteractionEnabled = YES;
    _button.titleLabel.font = [UIFont boldSystemFontOfSize:8];
    
    [_button setTitle:@" 友情提醒" forState:UIControlStateNormal];
    
    _bigbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 71)];
    
    
    [_bigbutton addSubview:_button];
    [self.contentView addSubview:_bigbutton];
    
    
    
    
    [self.contentView addSubview:_button];
    _ProView = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-105, 0, 55, 22)];
//    _ProView.image = [UIImage imageNamed:@"btn_tx1.png"];
    
    _Prolabel = [[UILabel alloc]initWithFrame:CGRectMake(10.5, 3, 34, 12)];
    _Prolabel.font = [UIFont systemFontOfSize:10];
    _Prolabel.textColor = [UIColor colorHexString:@"ffffff"];
    _Prolabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:8];
    _Prolabel.textAlignment = NSTextAlignmentCenter;
    [_ProView addSubview:_Prolabel];
    
    [self.contentView addSubview:_ProView];
    
    _RightView = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-24, 28, 9, 15)];
    _RightView.image = [UIImage imageNamed:@"btn_more"];
    [self.contentView addSubview:_RightView];
    
    _lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 70, zScreenWidth, 1)];
    _lineview.backgroundColor = [UIColor colorHexString:@"e8ebec"];
    [self.contentView addSubview:_lineview];
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    _seclabel.text = dataDic[@"title"];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
