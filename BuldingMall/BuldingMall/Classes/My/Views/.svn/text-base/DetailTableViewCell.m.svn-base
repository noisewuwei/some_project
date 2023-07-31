//
//  DetailTableViewCell.m
//  BuldingMall
//
//  Created by noise on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 75, 75)];
        _image.layer.cornerRadius = 3;
        [_image.layer setBorderWidth:0.5];
        [_image.layer setBorderColor:[UIColor colorHexString:@"e8ebec"].CGColor];
        [_image.layer setMasksToBounds:YES];
        _nameLabel= [[UILabel alloc]initWithFrame:CGRectMake(100, 15, zScreenWidth-100-15-80, 35)];
        _nameLabel.textColor = [UIColor colorHexString:@"333333"];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.numberOfLines = 0;
        
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-95, 15, 80, 15)];
        _price.font = [UIFont systemFontOfSize:13];
        _price.textAlignment = NSTextAlignmentRight;
        _price.textColor = [UIColor colorHexString:@"333333"];
        
        
        _heheprice = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-95, 45, 80,15 )];
        _heheprice.font = [UIFont systemFontOfSize:13];
        _heheprice.textAlignment = NSTextAlignmentRight;
        _heheprice.textColor = [UIColor colorHexString:@"999999"];
        
//        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 7.5, 80, 0.5)];
//        view1.backgroundColor = [UIColor colorHexString:@"999999"];

        
//        [_heheprice addSubview:view1];
        
//        _countname = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 30, 14)];
//        _countname.font = [UIFont systemFontOfSize:10];
//        _countname.textColor = [UIColor colorHexString:@"808080"];
//        _countname.text = @"数量:";
        
        _count = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-65, 70 , 50, 14)];
        _count.font = [UIFont systemFontOfSize:13];
        _count.textAlignment = NSTextAlignmentRight;
        _count.textColor = [UIColor colorHexString:@"808080"];
        
        
        _standLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,50, zScreenWidth-100-15-80, 40)];
        _standLabel.textColor = [UIColor colorHexString:@"808080"];
        _standLabel.font = [UIFont systemFontOfSize:10];
        _standLabel.numberOfLines = 0;
//        _standnumLabel = [[UILabel alloc]initWithFrame:CGRectMake(190, 60, zScreenWidth-190-79-15, 14)];
//        _standnumLabel.textColor = [UIColor colorHexString:@"808080"];
//        _standnumLabel.font = [UIFont systemFontOfSize:10];
        _click = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-79, 95, 79, 30)];
        [_click setTitle:@"查看进度" forState:UIControlStateNormal];
        [_click setTitleColor:[UIColor colorHexString:@"f22d2d"] forState:UIControlStateNormal];
        _click.titleLabel.font = [UIFont systemFontOfSize:15];
        _click.layer.cornerRadius = 2;
        [_click.layer setBorderWidth:1];
        [_click.layer setBorderColor:[UIColor colorHexString:@"f89191"].CGColor];
        [_click.layer setMasksToBounds:YES];
        
        [self addSubview:_countname];
        [self addSubview:_count];
        [self addSubview:_price];
        [self addSubview:_heheprice];
        [self addSubview:_image];
        [self addSubview:_nameLabel];
        [self addSubview:_standnumLabel];
        [self addSubview:_standLabel];
        [self addSubview:_click];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
