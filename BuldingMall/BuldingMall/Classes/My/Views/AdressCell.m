//
//  AdressCell.m
//  BuldingMall
//
//  Created by noise on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "AdressCell.h"
#import "UpdateAddressController.h"

@implementation AdressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 145)];
        backview.backgroundColor = [UIColor whiteColor];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorHexString:@"333333"];
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-160-15, 15, 160, 15)];
        _numLabel.font = [UIFont systemFontOfSize:16];
        _numLabel.textColor = [UIColor colorHexString:@"333333"];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+20, zScreenWidth-30, 40)];
        _adressLabel.numberOfLines = 0;
        _adressLabel.textColor = [UIColor colorHexString:@"333333"];
        _adressLabel.font = [UIFont systemFontOfSize:16];
        
        _adressButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 145-15-19, 130, 25)];
        _adressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _adressButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _adressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_adressButton setTitle:@"  设为默认地址" forState:UIControlStateNormal];
        [_adressButton setTitle:@"  默认地址" forState:UIControlStateSelected];
        [_adressButton setImage:[UIImage imageNamed:@"btn_an.png"] forState:UIControlStateNormal];
        [_adressButton setImage:[UIImage imageNamed:@"btn_ok"] forState:UIControlStateSelected];
        [_adressButton setTitleColor:[UIColor colorHexString:@"cccccc"] forState:UIControlStateNormal];
        [_adressButton setTitleColor:[UIColor colorHexString:@"1db761"] forState:UIControlStateSelected];
        _adressButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-135, 145-15-19, 65, 25)];
        [_editButton setTitle:@" 编辑" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"btn_edit1.png"] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor colorHexString:@"333333"] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-70, 145-15-19, 65, 25)];
        [_deleteButton setTitle:@" 删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"btn_delete2.png"] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorHexString:@"333333"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 145-15-25-3, zScreenWidth-30, 1)];
        view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
        
        
        [self.contentView addSubview:backview];
        [backview addSubview:view];
        [backview addSubview:_nameLabel];
        [backview addSubview:_numLabel];
        [backview addSubview:_adressLabel];
        [backview addSubview:_adressButton];
        [backview addSubview:_editButton];
        [backview addSubview:_deleteButton];
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
