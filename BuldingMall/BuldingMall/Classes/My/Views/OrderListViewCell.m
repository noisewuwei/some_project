//
//  OrderListViewCell.m
//  BuldingMall
//
//  Created by zfy on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "OrderListViewCell.h"
#import "ListModel.h"
#import "PaymentController.h"
#import "OderListController.h"
#import "DetailController.h"
#define kOrderListUrl @"OrderList"//我的订单列表的接口

@interface OrderListViewCell()<UIAlertViewDelegate>
{
    NSInteger status;
    
    NSInteger down_payment;
    
    
}
@property(nonatomic,strong)ListModel *model;
@property (retain) MBProgressHUD *HUD;
@property(nonnull,strong)OderListController *orderList;

@end
@implementation OrderListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.picBtn.layer.masksToBounds = YES;
//    self.picBtn.layer.cornerRadius = 5;
//    self.picBtn.layer.borderWidth = 1;
//    self.picBtn.layer.borderColor = [UIColor colorHexString:@"#e8ebec"].CGColor;
//    
    self.seeListBtn.layer.masksToBounds = YES;
    self.seeListBtn.layer.cornerRadius = 5;
    self.seeListBtn.layer.borderWidth = 1;
    self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#808080"].CGColor;
    
    self.picImg.layer.masksToBounds = YES;
    self.picImg.layer.borderWidth = 1;
    self.picImg.layer.cornerRadius = 5;
    self.picImg.layer.borderColor = [UIColor colorHexString:@"#e8ebec"].CGColor;
    
    self.dingbtnn.layer.masksToBounds = YES;
    self.dingbtnn.layer.cornerRadius = 5;
    self.dingbtnn.layer.borderWidth = 1;
    self.dingbtnn.layer.borderColor = [UIColor colorHexString:@"#dd2727"].CGColor;
    
    
}
-(void)addTheValue:(ListModel *)listModel
{
    _model = listModel;
    
    NSLog(@"orderid%@",listModel.Id);
    
    self.timeLab.text = listModel.createdate;
    
    self.bianHaoLab.text = listModel.no;
    
    self.status_name.text = listModel.status;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",listModel.price];
    
    [self.picImg sd_setImageWithURL:[NSURL URLWithString:YouJuKeImageUrl(listModel.image)]];
    
    //11月2号 增加已付定金10元判断代码
    down_payment = [listModel.down_payment integerValue];
    
    if (down_payment == 0)
    {
        
        self.dingview.hidden = YES;
        
    }
    else
        
    {
        
        self.dingview.hidden = NO;
        NSString *tt = [NSString stringWithFormat:@"已付定金￥%@",listModel.down_payment];
        NSLog(@"listmodel.down_payment%@",listModel.down_payment);
        [self.dingbtnn setTitle:tt forState:UIControlStateNormal];
        
        
    }
    
    
    //0-取消订单后删除 ，1-待付款，2-待发货，3-待收货，4-待评价，5-已取消，6-评价成功，7-评价成功后删除，8-退货处理中，9-退货关闭，10-同意退货，11-退货成功，12-修改订单编号
    
     status = [listModel.status_id integerValue];
    
    if (status == 1)
    {
        [self.seeListBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#f22d2d"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#f89191"].CGColor;
        self.status_name.textColor = [UIColor colorHexString:@"#f22f2f"];
        self.DelView.hidden = YES;
//        self.seeListBtn.tag = 20000;
        [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else if (status == 2)
    {
        [self.seeListBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        self.DelView.hidden = YES;
       
        [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#333333"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#808080"].CGColor;
        self.status_name.textColor = [UIColor blackColor];
        [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
       

        
    }
    else if (status == 3)
    {
        [self.seeListBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#f22d2d"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#f89191"].CGColor;
        self.status_name.textColor = [UIColor colorHexString:@"#f22f2f"];
        self.DelView.hidden = YES;
        
        [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        

    }
    else if (status == 4)
    {
        
        [self.seeListBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        
        self.DelView.hidden = YES;
        [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#333333"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#808080"].CGColor;
        self.status_name.textColor = [UIColor blackColor];
       [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    else if(status == 5)
        
    {
        [self.seeListBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        
         self.DelView.hidden = NO;
        [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#333333"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#808080"].CGColor;
        self.status_name.textColor = [UIColor blackColor];
       [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];



    }
    else
    {
        
        [self.seeListBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        
        self.DelView.hidden = YES;
       [self.seeListBtn setTitleColor:[UIColor colorHexString:@"#333333"] forState:UIControlStateNormal];
        self.seeListBtn.layer.borderColor = [UIColor colorHexString:@"#808080"].CGColor;
        self.status_name.textColor = [UIColor blackColor];
        [self.seeListBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}
- (IBAction)DelBtnClick:(UIButton *)sender
{
    
    
    NSLog(@"点击删除按钮触发的事件");
    
    if (status == 5)
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除这条订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        aler.tag = 1111;
        
        [aler show];
    }
    
   
    
}


-(void)seeBtnClick:(UIButton *)seeOrderBtn
{
    if (status == 1)
    {
        PaymentController *pay = [[PaymentController alloc]init];
        
        pay.order_no = _model.Id;
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrder) name:@"change" object:nil];
        
       [self.nav pushViewController:pay animated:YES];
        
    }
    else if (status == 3)
    {
        
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认这条订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        aler.tag = 111;
        
        [aler show];
        
    }
    
   else if (status == 2 || status == 4 || status == 5)
       
    {
        DetailController *detail = [[DetailController alloc] init];
        
        detail.orderId = _model.Id;
        
        [self.nav pushViewController:detail animated:YES];
    }
    else
    {
        DetailController *detail = [[DetailController alloc] init];
        
        detail.orderId = _model.Id;
        
        [self.nav pushViewController:detail animated:YES];
        
    }
    
    
    
}

-(void)refreshOrder
{
    
    if (self.delCellBack)
    {
        self.delCellBack();
    }
    

}
#pragma mark--UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1111)
    {
        if (buttonIndex == 1)
        {
            
            NSDictionary * dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
            NSString *Id = dataDic[@"id"];
            
            //点击删除按钮请求数据
            [self loadDataOrderListFormServer:@"transfer_order" params:@{@"user_id":Id,@"order_id":_model.Id,@"status":@"0"}];
            
            
            
        }
        
    }
    else
    {
        if (buttonIndex == 1)
        {
            
            NSDictionary * dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
            NSString *Id = dataDic[@"id"];
            
            //点击确认收货请求数据
            [self loadDataOrderListFormServer:@"transfer_order" params:@{@"user_id":Id,@"order_id":_model.Id,@"status":@"4"}];
            
            
            
        }
        

    }
}


//主列表删除的请求数据
-(void)loadDataOrderListFormServer:(NSString *)url params:(NSDictionary *)param
{

    
    //第一个待付款按钮触发的列表请求数据
    [HTTPRequest postWithURL:url params:param ProgressHUD:_HUD controller:nil response:^(id json)
     {
         
         NSLog(@"删除订单%@",json);
         
     [ZJStaticFunction alertView:self msg:@"操作成功"];
         
         if (self.delCellBack)
         {
              self.delCellBack();
         }
         
    
     } error400Code:^(id failure)
     {
         
     }];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
