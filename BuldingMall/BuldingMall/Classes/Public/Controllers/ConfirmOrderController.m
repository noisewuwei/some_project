//
//  ConfirmOrderController.m
//  BuldingMall
//
//  Created by Jion on 16/9/12.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "PaymentController.h"
#import "ShippAddressController.h"

@interface ConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel   *worthLabel;
@property(nonatomic,strong)AdressModel *adressModel;
@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    [self buildView];
}
-(void)buildView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight - 50) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, zScreenHeight-50-zNavigationHeight, zScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bottomView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.3;
    [bottomView addSubview:lineView];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(zScreenWidth-100, 10, 80, 30);
    payBtn.backgroundColor = [UIColor redColor];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    payBtn.layer.cornerRadius = 4.0;
    payBtn.layer.masksToBounds = YES;
    payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    
    _worthLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, zScreenWidth-150, 49)];
    _worthLabel.textAlignment = NSTextAlignmentLeft;
    NSString *string = _buildOrderModel.actual_fee ?[NSString stringWithFormat:@"实付款:￥%0.2f",[_buildOrderModel.actual_fee floatValue]]:@"实付款:￥0.00";
    _worthLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(4, string.length-4)];
    [bottomView addSubview:_worthLabel];
    
}
-(void)changeAddressFromServer:(AdressModel*)adressModel{
    [self.Hud show:YES];
    NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",adressModel.city,adressModel.district,adressModel.address];
    
    NSDictionary *param = @{@"user_id":user_id,
                            @"order_id":_buildOrderModel.order_id,
                            @"consignee":adressModel.receive_name,
                            @"consignee_contact":adressModel.mobile,
                            @"accept_address":address};
    
    [HTTPRequest postWithURL:@"update_order" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        if (!json) {
            _adressModel = adressModel;
            [self.tableView reloadData];
        }
    } error400Code:^(id failure) {
        
    }];
}

#pragma mark -- Action
-(void)payActionClick:(UIButton*)sender{
    PaymentController *payment = [[PaymentController alloc] init];
    payment.order_no = _buildOrderModel.order_id;
    [self.navigationController pushViewController:payment animated:YES];
}
-(void)goToAddressAction{
    
    ShippAddressController *addressList = [[ShippAddressController alloc] init];
    addressList.addressCallBack = ^(AdressModel* adressModel){
        [self changeAddressFromServer:adressModel];
    };
    [self.navigationController pushViewController:addressList animated:YES];
}

#pragma mark --UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *subHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 10, zScreenWidth, 80)];
    subHeader.backgroundColor = [UIColor whiteColor];
    [header addSubview:subHeader];
    
    UIButton *goAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    goAddress.frame = CGRectMake(zScreenWidth - 50, 10, 50, 60);
    [goAddress setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
    [goAddress addTarget:self action:@selector(goToAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [subHeader addSubview:goAddress];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, zScreenWidth - 60, 20)];
    userLabel.font = [UIFont systemFontOfSize:16];
    [subHeader addSubview:userLabel];
    
    AdressModel *addressModel = _buildOrderModel.address;
    NSString *userName = [NSString stringWithFormat:@"%@     %@",addressModel.receive_name,addressModel.mobile];
    if (_adressModel) {
        userName = [NSString stringWithFormat:@"%@     %@",_adressModel.receive_name,_adressModel.mobile];
    }
    userLabel.text = userName;
    
    UIImageView *addressImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(userLabel.frame)+10, 15, 15)];
    addressImg.contentMode = UIViewContentModeScaleAspectFit;
    addressImg.image = [UIImage imageNamed:@"btn_add1.png"];
    [subHeader addSubview:addressImg];
    
    UILabel *addressLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressImg.frame)+10, CGRectGetMaxY(userLabel.frame)+10, zScreenWidth - 70, 15)];
    addressLable.numberOfLines = 0;
    addressLable.font = [UIFont systemFontOfSize:13];
    addressLable.textColor = [UIColor colorHexString:@"#808080"];
    [subHeader addSubview:addressLable];
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",addressModel.province,addressModel.city,addressModel.district,addressModel.address];
    if (_adressModel) {
        address = [NSString stringWithFormat:@"%@ %@ %@ %@",_adressModel.province,_adressModel.city,_adressModel.district,_adressModel.address];
    }
    
    addressLable.text = address;
    [addressLable sizeToFit];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 110;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    
    UILabel *totalText = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 20)];
    totalText.font = [UIFont systemFontOfSize:13];
    totalText.textColor = [UIColor colorHexString:@"#808080"];
    totalText.text = @"商品总价：";
    [footer addSubview:totalText];
    
    UILabel *totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, zScreenWidth - 110, 20)];
    totalPrice.font = [UIFont systemFontOfSize:13];
    totalPrice.textAlignment = NSTextAlignmentRight;
    totalPrice.textColor = [UIColor colorHexString:@"#808080"];
    [footer addSubview:totalPrice];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",_buildOrderModel.total_fee];
    totalPrice.text = price;
    
    UILabel *redText = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(totalText.frame), 80, 20)];
    redText.font = [UIFont systemFontOfSize:13];
    redText.textColor = [UIColor colorHexString:@"#808080"];
    redText.text = @"红包抵扣：";
    [footer addSubview:redText];
    
    UILabel *redPrice = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(totalPrice.frame), zScreenWidth - 110, 20)];
    redPrice.font = [UIFont systemFontOfSize:13];
    redPrice.textColor = [UIColor colorHexString:@"#808080"];
    redPrice.textAlignment = NSTextAlignmentRight;
    [footer addSubview:redPrice];
    
    NSString *red = [NSString stringWithFormat:@"￥%@",_buildOrderModel.available_red_packet?_buildOrderModel.available_red_packet:@"0"];
    redPrice.text = red;
  /*
    UILabel *couponText = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(redText.frame), 80, 20)];
    couponText.font = [UIFont systemFontOfSize:13];
    couponText.textColor = [UIColor colorHexString:@"#808080"];
    couponText.text = @"优惠券抵扣：";
    [footer addSubview:couponText];
    
    UILabel *couponPrice = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(redPrice.frame), zScreenWidth - 110, 20)];
    couponPrice.font = [UIFont systemFontOfSize:13];
    couponPrice.textColor = [UIColor colorHexString:@"#808080"];
    couponPrice.textAlignment = NSTextAlignmentRight;
    [footer addSubview:couponPrice];
    
    NSString *coupon = [NSString stringWithFormat:@"-￥%@",_buildOrderModel.voucher];
    couponPrice.text = coupon;
   */
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(redText.frame)+10, zScreenWidth, 1)];
    line.backgroundColor = [UIColor colorHexString:@"#808080"];
    line.alpha = 0.3;
    [footer addSubview:line];
    
    UILabel *realText = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame)+10, 80, 20)];
    realText.font = [UIFont boldSystemFontOfSize:15];
    realText.text = @"实付款：";
    [footer addSubview:realText];
    
    UILabel *realPrice = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(line.frame)+10, zScreenWidth - 110, 20)];
    realPrice.font = [UIFont systemFontOfSize:15];
    realPrice.textAlignment = NSTextAlignmentRight;
    realPrice.textColor = [UIColor colorHexString:@"#f22d2d"];
    [footer addSubview:realPrice];
    NSString *realprice = [NSString stringWithFormat:@"￥%0.2f",[_buildOrderModel.actual_fee floatValue]];
    realPrice.text = realprice;

    return footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _buildOrderModel.good_items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildCellView:cell];
    }
    ClassificationModel *classificationModel = _buildOrderModel.good_items[indexPath.row];
    
    NSString *img_url = classificationModel.good_image;
    UIImageView *imgView = [cell viewWithTag:201];
    [imgView sd_setImageWithURL:[NSURL URLWithString:YouJuKeImageUrl(img_url)] placeholderImage:[UIImage imageNamed:@""]];
    
    UILabel *contentLabel = [cell viewWithTag:202];
    NSString *good_name = classificationModel.good_name;
    contentLabel.text = good_name;
    [contentLabel sizeToFit];
    
    //购买价
    NSString *current_price = [NSString stringWithFormat:@"￥%@",classificationModel.sale_price];
    UILabel *currentPrice = [cell viewWithTag:203];
    currentPrice.text = current_price;
    
    //原价
    NSString *originalPrice = [NSString stringWithFormat:@"￥%@",classificationModel.classification_original_cost];
    UILabel *referencePrice = [cell viewWithTag:204];
    referencePrice.attributedText = [self deleteLine:originalPrice];
    
    //数量
    NSString *number = [NSString stringWithFormat:@"x%@",classificationModel.classification_num];
    UILabel *numberLabel = [cell viewWithTag:206];
    numberLabel.text = number;
    
    //规格型号
    UILabel *specLabel = [cell viewWithTag:205];
    NSString *spec = [NSString stringWithFormat:@"规格型号：%@",classificationModel.classification_name];
    specLabel.text = spec;
    [specLabel sizeToFit];
    
    return cell;
}

-(void)buildCellView:(UITableViewCell*)cell{
    cell.contentView.backgroundColor = [UIColor colorHexString:@"#f8f8f8"];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 100)];
    bgView.tag = 100;
    bgView.backgroundColor = [UIColor whiteColor];
    
    [cell.contentView addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.tag = 201;
    imgView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:imgView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, 15, bgView.frame.size.width-180, 30)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.tag = 202;
    [bgView addSubview:contentLabel];
    
    UILabel *currentPrice = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth - 90, 15, 80, 20)];
    currentPrice.font = [UIFont systemFontOfSize:13];
    currentPrice.tag = 203;
    currentPrice.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:currentPrice];
    
    UILabel *referencePrice = [[UILabel alloc] initWithFrame:CGRectMake(currentPrice.frame.origin.x, CGRectGetMaxY(currentPrice.frame), 80, 20)];
    referencePrice.font = [UIFont systemFontOfSize:13];
    referencePrice.textAlignment = NSTextAlignmentRight;
    referencePrice.tag = 204;
    [bgView addSubview:referencePrice];
    
    UILabel *specLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(contentLabel.frame)+20, zScreenWidth - 160, 25)];
    specLabel.font = [UIFont systemFontOfSize:10];
    specLabel.numberOfLines = 0;
    specLabel.textColor = [UIColor colorHexString:@"#959595"];
    specLabel.tag = 205;
    [bgView addSubview:specLabel];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentPrice.frame.origin.x, CGRectGetMaxY(referencePrice.frame), 80, 20)];
    numberLabel.font = [UIFont systemFontOfSize:10];
    numberLabel.textAlignment = NSTextAlignmentRight;
    numberLabel.textColor = [UIColor colorHexString:@"#959595"];
    numberLabel.tag = 206;
    [bgView addSubview:numberLabel];
    
    UILabel *orderType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(specLabel.frame), 100, 20)];
    orderType.font = [UIFont systemFontOfSize:12];
    orderType.tag = 207;
    [bgView addSubview:orderType];

}

- (NSAttributedString*)attributedChangeString:(NSString*)string range:(NSRange)range{
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return attributed;
}
-(NSAttributedString*)deleteLine:(NSString*)str{
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:str
                                  attributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:12.f],
    NSForegroundColorAttributeName:[UIColor colorHexString:@"#959595"],
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:[UIColor colorHexString:@"#959595"]}];

    return attrStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
