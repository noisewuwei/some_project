//
//  OneSnatchController.m
//  BuldingMall
//
//  Created by Jion on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "OneSnatchController.h"
#import "PaymentController.h"
#import "UITextField+Extension.h"

@interface OneSnatchController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITextField  *mobileField;
@property(nonatomic,strong)UITextField  *numberField;
@property(nonatomic,strong)UILabel   *worthLabel;
@end

@implementation OneSnatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"一元夺宝";
    [self buildView];
}

-(void)buildView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 120)];
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, zScreenWidth, 30)];
    contactLabel.textAlignment = NSTextAlignmentCenter;
    contactLabel.font = [UIFont systemFontOfSize:16];
    contactLabel.text = @"请填写联系方式";
    [headerView addSubview:contactLabel];
    UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contactLabel.frame), zScreenWidth, 20)];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.font = [UIFont systemFontOfSize:12];
    warnLabel.textColor = [UIColor orangeColor];
    warnLabel.text = @"用于中奖时第一时间通知您";
    [headerView addSubview:warnLabel];
    
    _mobileField= [[UITextField alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(warnLabel.frame)+10, zScreenWidth - 80, 30)];
    _mobileField.borderStyle = UITextBorderStyleRoundedRect;
    _mobileField.title = @"请输入您的手机号";
    _mobileField.shouldInputAccessoryView = YES;
    
    _mobileField.font = [UIFont systemFontOfSize:14];
    _mobileField.placeholder = @"请输入您的手机号";
    _mobileField.keyboardType = UIKeyboardTypePhonePad;
    NSDictionary *userInfo = [ZJStoreDefaults getObjectForKey:LoginSucess];
    NSString *user_mobile = [userInfo objectForKey:@"username"];
    if (user_mobile) {
         _mobileField.text = user_mobile;
    }
    [headerView addSubview:_mobileField];
   
    self.tableView.tableHeaderView = headerView;
    
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
    [payBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    
    _worthLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, zScreenWidth-150, 49)];
    _worthLabel.textAlignment = NSTextAlignmentLeft;
    NSString *string = @"实付款:￥1.00";
    _worthLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(4, string.length-4)];
    [bottomView addSubview:_worthLabel];
}

#pragma mark -- Action
-(void)payActionClick:(UIButton*)sender{
    NSLog(@"手机号：%@ /n 数量：%@",_mobileField.text,_numberField.text);
    PaymentController *payment = [[PaymentController alloc] init];
//    payment.order_no = _buildOrderModel.order_no;
    [self.navigationController pushViewController:payment animated:YES];
}

#pragma mark -- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
        image.tag = 201;
        image.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:image];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+10, 10, zScreenWidth - 140, 30)];
        contentLabel.tag = 202;
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.numberOfLines = 0;
        [cell.contentView addSubview:contentLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth - 30, 10, 20, 20)];
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textColor = [UIColor colorHexString:@"#808080"];
        priceLabel.tag = 203;
        [cell.contentView addSubview:priceLabel];
        
        UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth - 40, CGRectGetMaxY(priceLabel.frame), 30, 20)];
        numberLable.font = [UIFont systemFontOfSize:12];
        numberLable.textAlignment = NSTextAlignmentCenter;
        numberLable.tag = 204;
        [cell.contentView addSubview:numberLable];
        
        UIView *numberView = [self numberView:CGPointMake(CGRectGetMaxX(image.frame)+10, CGRectGetMaxY(contentLabel.frame)+10)];
        numberView.tag = 205;
        [cell.contentView addSubview:numberView];
    }
    
    UILabel *content = [cell viewWithTag:202];
    content.text = @"优居客商品测试数据，优居客商品测试数据优居客商品测试数据";
    [content sizeToFit];
    
    UILabel *priceLabel = [cell viewWithTag:203];
    priceLabel.text = @"￥1";
    [priceLabel sizeToFit];
    
    return cell;
}

-(UIView*)numberView:(CGPoint)point{
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 150, 30)];
    numberView.layer.borderColor = [[UIColor colorHexString:@"#959595"] CGColor];
    numberView.layer.borderWidth = 1.0;
    
    UIView *verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(numberView.frame.size.width/3, 0, 1, numberView.frame.size.height)];
    verticalLine1.backgroundColor = [UIColor colorHexString:@"#959595"];
    [numberView addSubview:verticalLine1];
    UIView *verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(numberView.frame.size.width*2/3, 0, 1, numberView.frame.size.height)];
    verticalLine2.backgroundColor = [UIColor colorHexString:@"#959595"];
    [numberView addSubview:verticalLine2];
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reduceBtn.frame = CGRectMake(0, 0, numberView.frame.size.width/3,  numberView.frame.size.height);
    reduceBtn.tag = 111;
    reduceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reduceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [reduceBtn addTarget:self action:@selector(changeBuyCount:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:reduceBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(numberView.frame.size.width*2/3, 0, numberView.frame.size.width/3,  numberView.frame.size.height);
    addBtn.tag = 222;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(changeBuyCount:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:addBtn];
    
    _numberField = [[UITextField alloc] initWithFrame:CGRectMake(numberView.frame.size.width/3, 0, numberView.frame.size.width/3,  numberView.frame.size.height)];
    _numberField.tag = 333;
    _numberField.textAlignment = NSTextAlignmentCenter;
    _numberField.enabled = NO;
    _numberField.text = @"1";
    [numberView addSubview:_numberField];
    
    return numberView;

}
#pragma mark -- Action
-(void)changeBuyCount:(UIButton*)sender{
    //减
    if (sender.tag == 111) {
        NSInteger count = [_numberField.text integerValue];
        if (count<=1) {
            return;
        }else{
            count = count - 1;
        }
        _numberField.text = [NSString stringWithFormat:@"%ld",(long)count];
        
    }else if (sender.tag == 222){
        //加
        NSInteger count = [_numberField.text integerValue]+1;
        if (count <= 10) {
            _numberField.text = [NSString stringWithFormat:@"%ld",count];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"库存不足啦!"];
        }
        
    }
    CGFloat current = [_numberField.text integerValue] * 1.00;
     NSString *string = [NSString stringWithFormat:@"实付款:￥%.2f",current];
    _worthLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(4, string.length-4)];
}


- (NSAttributedString*)attributedChangeString:(NSString*)string range:(NSRange)range{
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return attributed;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
