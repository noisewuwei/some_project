//
//  DetailController.m
//  BuldingMall
//
//  Created by noise on 16/9/12.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "DetailController.h"
#import "DetailTableViewCell.h"
#import "DetailModel.h"
#import "HTTPRequest.h"
#import "ZJStoreDefaults.h"
#import "DetailGoodsModel.h"
#import "CustomerServiceVC.h"
#import "ScheduleViewController.h"
#import "PaymentController.h"
#import "OderListController.h"
#import "ProductDetailController.h"
#import "ZJTabBarController.h"
#import "CountDown.h"

@interface DetailController (){
    DetailModel *model;
    NSMutableArray *tempArr;
    UILabel *tsprice;//实付款数字
    UIView *BView;
    UILabel *leftLabel;
}
@property (retain) MBProgressHUD *HUD;
@property (strong, nonatomic)  CountDown *countDownForLabel;
@end

@implementation DetailController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarLeftWithImage:@"back_9x16.png"];
    
    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
    NSString *userid = [obj valueForKey:@"id"];
    
    NSDictionary *dic = @{@"uid":userid,@"order_id":_orderId};

    NSLog(@"%@",_orderId);
    
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:@"OrderItem" params:dic ProgressHUD:self.HUD controller:self response:^(id json) {
        
        NSDictionary *result = (NSDictionary *)json;
        NSLog(@"%@",result);
        model = [DetailModel initDetailWithDict:result];
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:model.goods];
        NSLog(@"%@",arr);
        tempArr = [NSMutableArray array];
        for (id dict in arr) {
            DetailGoodsModel *model1 = [DetailGoodsModel initDetailGoodsWithDict:dict];
            [tempArr addObject:model1];
            
        }
        [self hehe];
        [self showBview];
        [self.tableView reloadData];
        
    } error400Code:^(id failure) {
        
    }];
    
    self.navigationItem.title = @"订单详情";
    
    self.view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tempArr.count;
}
//表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float heigh;
    if ([model.is_virtual_product intValue]==0) {
        heigh = 168;
    }else if([model.is_virtual_product intValue]==1){
        heigh = 80;
    }
    
    return heigh;
}
//编辑表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerID = @"headerID";
    UITableViewHeaderFooterView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    UIImageView *imageview;
    UIView *Hview;
    UILabel *waitLabel;
    UILabel *nameLabel;
    UILabel *numLabel;
    UILabel *adressLabel;
    UIImageView *topimageview;
    UIImageView *downimageview;
    if (headview == nil) {
        headview = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerID];
    }
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 70)];
    imageview.image = [UIImage imageNamed:@"top_bg1.png"];
    
    [headview addSubview:imageview];
    
  
    if ([model.is_virtual_product intValue] != 1 && model.is_virtual_product) {
        Hview = [[UIView alloc]initWithFrame:CGRectMake(0, 80, zScreenWidth, 78)];
        Hview.backgroundColor = [UIColor whiteColor];
        downimageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 48, 12, 15 )];
        downimageview.image = [UIImage imageNamed:@"btn_add1"];
        adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+12+10, 40, zScreenWidth-37, 32)];
        adressLabel.textColor = [UIColor colorHexString:@"808080"];
        adressLabel.font = [UIFont systemFontOfSize:13];
        adressLabel.numberOfLines = 0;
        adressLabel.text = [model.accept_address stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+12+10, 19,70, 13)];
        nameLabel.textColor = [UIColor colorHexString:@"333333"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.text = model.consignee;
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+12+10+80, 19, zScreenWidth-37-90, 13)];
        numLabel.textColor = [UIColor colorHexString:@"333333"];
        numLabel.font = [UIFont systemFontOfSize:16];
        numLabel.text = model.mobile;
        [Hview addSubview:adressLabel];
        [Hview addSubview:downimageview];
        [Hview addSubview:nameLabel];
        [Hview addSubview:numLabel];
        [headview addSubview:Hview];
    }
   
    if ([model.status_id isEqualToString: @"1"]) {

        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-114-51+30+20, 15, 51, 40)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_dfk"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(37, 15, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
        leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(37, 38,zScreenWidth/2+20, 14)];
        leftLabel.textColor = [UIColor colorHexString:@"ffffff"];
        leftLabel.font = [UIFont systemFontOfSize:12];
        
        NSLog(@"%@",model.ex_time);
        
//        int num = [model.ex_time intValue];
//        int day = num/(60*60*24);
//        int day1 = num%(60*60*24);
//        int hour = day1/(60*60);
//        int hour1 = day1%(60*60);
//        int min = hour1/60;
//        int min1 = hour1%60;
//        int sec = min1;
//        
//        NSString *d = [NSString stringWithFormat:@"%d",day];
//        NSString *h = [NSString stringWithFormat:@"%d",hour];
//        NSString *m = [NSString stringWithFormat:@"%d",min];
//        NSString *s = [NSString stringWithFormat:@"%d",sec];
//        
//        leftLabel.text = [NSString stringWithFormat:@"剩%@天%@小时%@分%@秒自动关闭",d,h,m,s];
        [headview addSubview:leftLabel];
        
        _countDownForLabel = [[CountDown alloc] init];
        long long startLongLong = 0;
        long long finishLongLong = [model.ex_time doubleValue]*1000;
        [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
        

    }else if ([model.status_id isEqualToString:@"0"]){
        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2+5, 15, 51, 40)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_dfh"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-60-5, 28, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
    }else if ([model.status_id isEqualToString:@"2"]){
        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2+5, 15, 51, 40)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_dfh"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-60-5, 28, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
    }else if ([model.status_id isEqualToString:@"3"]){
        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2+5, 15, 51, 40)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_dsh"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-60-5, 28, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
    }else if ([model.status_id isEqualToString:@"4"]){
        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2+5, 10, 51, 50)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_dpj"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-60-5, 28, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
    }else if ([model.status_id isEqualToString:@"5"]){
        topimageview = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2+5, 15, 51, 40)];
        topimageview.contentMode = UIViewContentModeCenter;
        topimageview.image = [UIImage imageNamed:@"btn_quxiao1"];
        waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-60-5, 28, 60, 14)];
        waitLabel.textColor = [UIColor colorHexString:@"ffffff"];
        waitLabel.font = [UIFont systemFontOfSize:16];
        waitLabel.text = model.status;
    }
    
    [headview addSubview:waitLabel];
    [headview addSubview:topimageview];
    return headview;

}
//编辑表尾
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *footerID = @"footerID";
    UITableViewHeaderFooterView *footview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    footview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UIView *view4;
    UILabel *tprice;//商品总价
    UILabel *ttprice;//商品总价数字
    UILabel *rprice;//红包抵扣
    UILabel *trprice;//红包抵扣数字
    UILabel *cprice;//抵用券抵扣
    UILabel *tcprice;//抵用券抵扣数字
    UILabel *sprice;//实付款
    UILabel *order;//订单编号：
    UILabel *ordernum;//订单编号数字
    UILabel *ordert;//下单时间：
    UILabel *ordertime;//下单时间数字
    UIButton *cbutton;//联系客服button
    UIButton *pbutton;//拨打电话button

    
    if (footview == nil) {
        footview = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footerID];
        
    }

    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, zScreenWidth, 82.5)];
    view1.backgroundColor = [UIColor whiteColor];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 93.5, zScreenWidth, 46)];
    view2.backgroundColor = [UIColor whiteColor];
    view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 149.5, zScreenWidth, 52)];
    view3.backgroundColor = [UIColor whiteColor];
    view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 202.5, zScreenWidth, 62)];
    view4.backgroundColor = [UIColor whiteColor];
    [footview addSubview:view1];
    [footview addSubview:view2];
    [footview addSubview:view3];
    [footview addSubview:view4];
    tprice = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+10, 150, 17.5)];
    tprice.textColor = [UIColor colorHexString:@"808080"];
    tprice.font = [UIFont systemFontOfSize:13];
    tprice.text = @"商品总价";
    ttprice = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-165, 10+10, 150, 17.5)];
    ttprice.textColor = [UIColor colorHexString:@"808080"];
    ttprice.font = [UIFont systemFontOfSize:13];
    ttprice.text = [NSString stringWithFormat:@"¥ %@",model.price];
    ttprice.textAlignment = NSTextAlignmentRight;
    rprice = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+10+17.5+5, 150, 17.5)];
    rprice.textColor = [UIColor colorHexString:@"808080"];
    rprice.font = [UIFont systemFontOfSize:13];
    rprice.text = @"红包抵扣";
    rprice.hidden = NO;
    trprice = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-165, 10+10+17.5+5, 150, 17.5)];
    trprice.textColor = [UIColor colorHexString:@"808080"];
    trprice.font = [UIFont systemFontOfSize:13];
    trprice.text = [NSString stringWithFormat:@"¥ %@",model.discount_price];
    trprice.textAlignment = NSTextAlignmentRight;
    trprice.hidden = NO;
    cprice = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+17.5*2, 150, 17.5)];
    cprice.textColor = [UIColor colorHexString:@"808080"];
    cprice.font = [UIFont systemFontOfSize:13];
    cprice.text = @"已付定金";
    tcprice = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-165, 10+20+17.5*2, 150, 17.5)];
    tcprice.textColor = [UIColor colorHexString:@"808080"];
    tcprice.font = [UIFont systemFontOfSize:13];
    tcprice.text = [NSString stringWithFormat:@"¥ %@",model.down_payment];
    tcprice.textAlignment = NSTextAlignmentRight;
    if ([model.down_payment intValue]!=0) {
        
        cprice.hidden = NO;
        
        tcprice.hidden = NO;
    }else{
        cprice.hidden = YES;
        
        tcprice.hidden = YES;
    }
    sprice = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+82.5+1+10, 150, 16)];
    sprice.textColor = [UIColor colorHexString:@"333333"];
    sprice.font = [UIFont systemFontOfSize:15];
    sprice.text = @"实付款";
    tsprice = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-165, 10+82.5+1+15, 150, 16)];
    tsprice.textColor = [UIColor colorHexString:@"f22d2d"];
    tsprice.font = [UIFont systemFontOfSize:15];
    tsprice.text = [NSString stringWithFormat:@"¥ %@",model.amount];
    tsprice.textAlignment = NSTextAlignmentRight;
    order = [[UILabel alloc]initWithFrame:CGRectMake(15, 202.5+15, 60, 16)];
    order.textColor = [UIColor colorHexString:@"808080"];
    order.font = [UIFont systemFontOfSize:12];
    order.text = @"订单编号:";
    ordernum = [[UILabel alloc]initWithFrame:CGRectMake(15+60, 202.5+15, 200, 16)];
    ordernum.textColor = [UIColor colorHexString:@"808080"];
    ordernum.font = [UIFont systemFontOfSize:12];
    ordernum.text = model.no;
    ordert = [[UILabel alloc]initWithFrame:CGRectMake(15, 202.5+15+16, 60, 16)];
    ordert.textColor = [UIColor colorHexString:@"808080"];
    ordert.font = [UIFont systemFontOfSize:12];
    ordert.text = @"下单时间:";
    ordertime= [[UILabel alloc]initWithFrame:CGRectMake(15+60, 202.5+15+16, 200, 16)];
    ordertime.textColor = [UIColor colorHexString:@"808080"];
    ordertime.font = [UIFont systemFontOfSize:12];
    ordertime.text = model.createdate;
    cbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, 160, 42)];
    cbutton.layer.cornerRadius = 2;
    cbutton.backgroundColor = [UIColor whiteColor];
    [cbutton.layer setBorderColor:[UIColor colorHexString:@"e8ebec"].CGColor];
    [cbutton.layer setBorderWidth:0.5];
    [cbutton.layer setMasksToBounds:YES];
    [cbutton addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(38, 12, 10*2, 9*2)];
    image1.image = [UIImage imageNamed:@"tbn_kefu.png"];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(68, 16.5, 100, 9)];
    label1.textColor = [UIColor colorHexString:@"333333"];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"联系客服";
    [cbutton addSubview:image1];
    [cbutton addSubview:label1];
    pbutton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-160, 5, 160, 42)];
    pbutton.layer.cornerRadius = 2;
    pbutton.backgroundColor = [UIColor whiteColor];
    [pbutton.layer setBorderColor:[UIColor colorHexString:@"e8ebec"].CGColor];
    [pbutton.layer setBorderWidth:0.5];
    [pbutton.layer setMasksToBounds:YES];
    [pbutton addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(38, 12, 10*2, 9*2)];
    image2.image = [UIImage imageNamed:@"btn_phone1.png"];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(68, 16.5, 100, 9)];
    label2.textColor = [UIColor colorHexString:@"333333"];
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"拨打电话";
    
    [pbutton addSubview:image2];
    [pbutton addSubview:label2];
    [view3 addSubview:cbutton];
    [view3 addSubview:pbutton];
    
    
    [footview addSubview:order];
    [footview addSubview:ordernum];
    [footview addSubview:ordert];
    [footview addSubview:ordertime];
    [footview addSubview:tprice];
    [footview addSubview:ttprice];
    [footview addSubview:rprice];
    [footview addSubview:trprice];
    [footview addSubview:cprice];
    [footview addSubview:tcprice];
    [footview addSubview:sprice];
    [footview addSubview:tsprice];
    return footview;
    
}

- (void)hehe{
    if ([model.status_id isEqualToString:@"1"]) {
        [self createRightTitle:@"取消订单" titleColor:[UIColor whiteColor]];
    }
}

- (void)showBview{
    
    if ([model.status_id isEqualToString:@"1"]) {
        
        [self.tableView setFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64-53)];
        
        UILabel *hehelabel;
        UILabel *hehedalabel;
        UIButton *hehebutton;
        
        BView = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-53-64, zScreenWidth, 53)];
        BView.backgroundColor = [UIColor colorHexString:@"f8f8f8"];
        hehelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, 60, 19)];
        hehelabel.textColor = [UIColor colorHexString:@"333333"];
        hehelabel.font = [UIFont systemFontOfSize:17];
        hehelabel.text = @"实付款:";
        
        hehedalabel = [[UILabel alloc]initWithFrame:CGRectMake(15+60, 17, 60, 19)];
        hehedalabel.textColor = [UIColor colorHexString:@"f22d2d"];
        hehedalabel.font = [UIFont systemFontOfSize:17];
        hehedalabel.text = [NSString stringWithFormat:@"¥ %@",model.amount];
        
        hehebutton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-78, 9.5 , 78 , 34)];
        hehebutton.backgroundColor = [UIColor colorHexString:@"f22d2d"];
        [hehebutton addTarget:self action:@selector(paymoney) forControlEvents:UIControlEventTouchUpInside];
        [hehebutton setTitle:@"立即支付" forState:UIControlStateNormal];
        [hehebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        hehebutton.layer.cornerRadius = 2;
        hehebutton.titleLabel.font = [UIFont systemFontOfSize:15];
        hehebutton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        [BView addSubview:hehelabel];
        [BView addSubview:hehedalabel];
        [BView addSubview:hehebutton];
        
        [self.view addSubview:BView];
    }else if ([model.status_id isEqualToString:@"3"]){
        
        [self.tableView setFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64-53)];
        
        UIButton *hehebutton;
        
        BView = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-53-64, zScreenWidth, 53)];
        BView.backgroundColor = [UIColor colorHexString:@"f8f8f8"];
        
        hehebutton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-78, 9.5 , 78 , 34)];
        hehebutton.backgroundColor = [UIColor colorHexString:@"f22d2d"];
        [hehebutton setTitle:@"确认收货" forState:UIControlStateNormal];
        [hehebutton addTarget:self action:@selector(comfireOrder) forControlEvents:UIControlEventTouchUpInside];
        [hehebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        hehebutton.layer.cornerRadius = 2;
        hehebutton.titleLabel.font = [UIFont systemFontOfSize:15];
        hehebutton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];

        [BView addSubview:hehebutton];
        
        [self.view addSubview:BView];
    }
    
}
//表尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 265;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DetailGoodsModel *models = [tempArr objectAtIndex:indexPath.row];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:YouJuKeImageUrl(models.image)]];
    cell.image.image = [UIImage imageWithData:data];
    cell.nameLabel.text = models.name;
    cell.standLabel.text = [NSString stringWithFormat:@"规格型号: %@",models.classification_name];
//    cell.standnumLabel.text = models.classification_name;
    cell.price.text = [NSString stringWithFormat:@"¥ %@",models.good_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",models.original_cost] attributes:attribtDic];
    cell.heheprice.attributedText = attribtStr;
//    cell.heheprice.attributedText = [NSString stringWithFormat:@"¥ %@",attribtStr];
//    cell.heheprice.text = [NSString stringWithFormat:@"¥ %@",models.original_cost];
    cell.count.text = [NSString stringWithFormat:@"x %@",models.num];
    [cell.click addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchDown];
    cell.click.tag = indexPath.row + 250;
    
    if ([model.status_id isEqualToString: @"1"]) {
        cell.click.hidden = YES;
    }else if ([model.status_id isEqualToString:@"5"]){
        cell.click.hidden = YES;
    }else if ([model.status_id isEqualToString:@"4"]){
        cell.click.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}
// 确认订单
- (void)comfireOrder{
    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
    NSString *userid = [obj valueForKey:@"id"];
    
    NSDictionary *dic = @{@"user_id":userid,@"order_id":_orderId,@"status":@"4"};
    
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:@"transfer_order" params:dic ProgressHUD:self.HUD controller:self response:^(id json) {
        
        [ZJStaticFunction alertView:self.navigationController.view msg:@"操作成功"];
        if (self.detailCallBack) {
            self.detailCallBack(@"接单后刷新主界面");
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } error400Code:^(id failure) {
        
        
    }];
    
    NSLog(@"comfireOrder");
}

-(void)showRight:(UIButton *)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认取消订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 191;
    [alert show];
    
}

- (void)chat{
    
    CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
    NSString *serviceUrl = @"http://m.youjuke.com/index/kf_html";
    customerService.webPath = @"/im/gateway";
    customerService.webRequestURL = serviceUrl;
    
    [self.navigationController pushViewController:customerService animated:YES];
}

- (void)phone{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"拨打电话4006891616" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 201;
    [alert show];
    
}
#pragma mark --UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 201) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://4006891616"]];
    
    }else if (buttonIndex == 1 && alertView.tag == 191){
        id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
        NSString *userid = [obj valueForKey:@"id"];
        
        NSDictionary *dic = @{@"user_id":userid,@"order_id":_orderId,@"status":@"5"};
        
        [self.HUD show:YES];
        
        [HTTPRequest postWithURL:@"transfer_order" params:dic ProgressHUD:self.HUD controller:self response:^(id json) {
            
            [ZJStaticFunction alertView:self.navigationController.view msg:@"操作成功"];
            
            if (self.detailCallBack) {
                self.detailCallBack(@"接单后刷新主界面");
            }
            
             [self.navigationController popViewControllerAnimated:YES];
            
        } error400Code:^(id failure) {
            NSLog(@"hehehe%@",failure);
        }];
       
    }
}

- (void)check:(UIButton *)clickBtn{
    ScheduleViewController *svc = [ScheduleViewController alloc];
    DetailGoodsModel *dmodel = tempArr[clickBtn.tag - 250];
    svc.DModel = dmodel;
    svc.ID = _orderId;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)paymoney{
    PaymentController *pvc = [PaymentController alloc];
    pvc.order_no = _orderId;
    [self.navigationController pushViewController:pvc animated:YES];
}
//重写返回方法 猪猪修改
-(void)showLeft:(UIButton *)sender{
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[OderListController class]]){
            
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }else if ([vc isKindOfClass:[ProductDetailController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
}

-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSString *time = [NSString stringWithFormat:@"剩%lu天%lu时%lu分%lu秒自动关闭",(unsigned long)day,(unsigned long)hour,(unsigned long)minute,(unsigned long)second];
    leftLabel.text = time;
}

-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
    __weak __typeof(self) weakSelf= self;
    
    [_countDownForLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
