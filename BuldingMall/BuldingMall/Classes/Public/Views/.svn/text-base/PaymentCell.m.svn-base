//
//  PaymentCell.m
//  BuldingMall
//
//  Created by Jion on 16/9/19.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "PaymentCell.h"
@interface PaymentCell()
@property(nonatomic,strong)PaymentModel *paymentModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgVew;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation PaymentCell

+(instancetype)shareCellWithTable:(UITableView*)tableView model:(PaymentModel*)model {
    static NSString *CellIdentifier = @"PaymentCell";
    PaymentCell *cell = (PaymentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.paymentModel = model;
    return cell;

}
-(void)setPaymentModel:(PaymentModel *)paymentModel{
    _paymentModel = paymentModel;
    
    [_selectBtn setImage:[UIImage imageNamed:@"btn_xz.png"] forState:UIControlStateSelected];
    [_selectBtn setImage:[UIImage imageNamed:@"btn_wxz.png"] forState:UIControlStateNormal];
    
    _imgVew.image = [UIImage imageNamed:paymentModel.imagName];
    _titleLabel.text = paymentModel.titleText;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation PaymentModel

@end
