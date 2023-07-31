//
//  MyTableViewCell.m
//  BuldingMall
//
//  Created by noise on 16/9/21.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell


//- (void)setIsShowImg:(BOOL)isShowImg
//{
//    _isShow = isShowImg;
//    
//    if (isShowImg) {
//        
//        _stateLabel.text = [NSString stringWithFormat:@"哥出来了😄"];
//    }
//    else
//    {
//        _stateLabel.text = [NSString stringWithFormat:@"大隐身之术👌"];
//        
//    }
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(23, 27, 8, 8)];
        
        _headImg.contentMode = UIViewContentModeCenter;
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(23+8+14, 10, zScreenWidth-60, 40)];
        _stateLabel.font = [UIFont systemFontOfSize:15];
        _stateLabel.numberOfLines = 0;
//        _stateLabel.textColor = [UIColor colorHexString:@"25ae5f"];
        
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(23+8+14,50, zScreenWidth/2+50, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
//        _timeLabel.textColor = [UIColor colorHexString:@"25ae5f"];
        
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(23+4, 0, 1, 79)];
        _view1.backgroundColor = [UIColor colorHexString:@"e8ebec"];
        
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(23+8+14, 78, zScreenWidth-60, 1)];
        _view2.backgroundColor = [UIColor colorHexString:@"e8ebec"];
        
        
        [self.contentView addSubview:_view1];
        [self.contentView addSubview:_view2];
        [self.contentView addSubview:_headImg];
        [self.contentView addSubview:_stateLabel];
        [self.contentView addSubview:_timeLabel];

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
