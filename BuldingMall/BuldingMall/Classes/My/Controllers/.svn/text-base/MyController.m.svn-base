//
//  MyController.m
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "MyController.h"
#import "UpImageDownTextBageButton.h"
#import "EventItemModel.h"
#import "OderListController.h"
#import "ShippAddressController.h"
#import "SettingController.h"
#import "LonginController.h"

#define kOrderTypeUrl @"OrderStatus"//几种状态的接口
@interface MyController ()
{
    UITableView *_table;
//    UIView *bgImg;
    NSDictionary * dataDic;
    NSString *Id;
    BOOL   _isRefresh;
}
@property (nonatomic,strong)NSArray *dataArray;
@property (retain) MBProgressHUD *HUD;
@property(nonatomic,strong)NSMutableArray *arrayArray;
@end

@implementation MyController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
    Id = dataDic[@"id"];
    NSLog(@"uid%@",Id);

    if (Id == nil)
    {
        NSArray *array = @[@{@"status_name":@"待付款",@"status_count":@"0"},@{@"status_name":@"待发货",@"status_count":@"0"},@{@"status_name":@"待收货",@"status_count":@"0"},@{@"status_name":@"待评价",@"status_count":@"0"}];
        NSMutableArray *modelArray = [EventItemModel objectArrayWithKeyValuesArray:array];
        _array = modelArray;
        [_table reloadData];
        
    }
    
    if (_isRefresh){
       [self showNumBerSever];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    self.view.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    
    [self setMyTab];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderState) name:@"changeOrder" object:nil];
    
}

-(void)refreshOrderState{
    
     _isRefresh = YES;
    
}


-(void)setMyTab
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, -21, zScreenWidth, zScreenHeight-zToolBarHeight) style:UITableViewStyleGrouped];
    
    _table.delegate = self;
    
    _table.dataSource = self;
    
//    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _table.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    
    [self.view addSubview:_table];
    
    [self showNumBerSever];
    
    
}

-(void)showNumBerSever
{
    
    dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
    Id = dataDic[@"id"];
    NSLog(@"uid%@",Id);
    [self loadDataFormServer:kOrderTypeUrl params:@{@"uid":Id}];
    

    
    
    
}
-(void)loadDataFormServer:(NSString *)url  params:(NSDictionary *)param
{
    _isRefresh = NO;
    
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.HUD controller:self response:^(id json) {
        NSLog(@"我的订单状态%@",json);
        
        NSArray *resultArray = (NSArray *)json;
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dc in resultArray)
        {
            EventItemModel *model = [EventItemModel initWithDict:dc];
            [tempArray addObject:model];
            
        }
        
        self.array = tempArray;
        
        NSLog(@"== %ld",(unsigned long)self.array.count);
        
        [_table reloadData];

        
        
    } error400Code:^(id failure)
     {
         
     }];

}
//如果Table为UITableViewStyleGrouped，需要设置header的高。
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
    
}
//返回多少块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
//返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 2;
        
    }
    else
    {
        return 1;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 160;
            
            
        }
        else
        {
            return 85;
            
        }
        
    }
    else
    {
        return 50;
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //选中时不让cell用任何灰色的样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            
            //顶部的布局界面
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([cell viewWithTag:8888])
            {
                [[cell viewWithTag:8888] removeFromSuperview];
                
            }

            UIView *topView = [self getTopView];
            topView.tag = 8888;
            [cell.contentView addSubview:topView];

            
        }
        else if(indexPath.row==1)
        {
            
            //中间几种状态的布局界面
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([cell viewWithTag:666])
            {
                [[cell viewWithTag:666] removeFromSuperview];
                
            }
            
            UIView *orderView = [self getItemRow];
            orderView.tag = 666;
            [cell.contentView addSubview:orderView];
            
            
        }
        
        
        
        
    }
    else
    {
        
        //收货地址的布局
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([cell viewWithTag:9999])
        {
            [[cell viewWithTag:9999] removeFromSuperview];
            
        }
        
        //实现右边的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView *shouView = [self addressView];
        
        shouView.tag = 9999;
        
        [cell.contentView addSubview:shouView];
        
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        
        if ([LonginController isLongin:self completion:nil])
        {
            
            ShippAddressController *shipAdd = [[ShippAddressController alloc]init];
            shipAdd.title = @"管理收货地址";
            [self.navigationController pushViewController:shipAdd animated:YES];
            
        }
        
    }
}

-(UIView *)getTopView
{
    UIView *getTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 160)];
    //创建背景图片
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 160)];
    bgImg.image = [UIImage imageNamed:@"top_bg.png"];
    bgImg.userInteractionEnabled = YES;
    [getTopView addSubview:bgImg];
    
    //创建右上角按钮
    UIButton *rigtBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-50, 16, 50, 40)];
    [rigtBtn setTitle:@"设置" forState:UIControlStateNormal];
    //            [rigtBtn setFont:[UIFont boldSystemFontOfSize:15.0]];
    rigtBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rigtBtn addTarget:self action:@selector(setClick:) forControlEvents:UIControlEventTouchUpInside];
    [rigtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgImg addSubview:rigtBtn];
    
    
    NSString *touImg  = dataDic[@"avatar"];
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(zScreenWidth/2-35, 40, 70, 70);
    [setBtn sd_setImageWithURL:[NSURL URLWithString:touImg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Head-portrait-1.png"]];
    setBtn.layer.cornerRadius = 35.0;
    setBtn.layer.masksToBounds = YES;
    [setBtn addTarget:self action:@selector(setClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImg addSubview:setBtn];
    
    
    //图像底部是显示昵称还是 登录的按钮
    if (Id == nil)
    {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-32, setBtn.frame.size.height+45,60, 30)];
        [btn setTitle:@"请登录" forState:UIControlStateNormal];
        
        [btn setTintColor:[UIColor blackColor]];
        
        [btn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgImg addSubview:btn];
        
        
    }
    else
    {
        UILabel *telLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-100, setBtn.frame.size.height + 45, 200, 30)];
        
        NSString *userName = dataDic[@"username"];
        
        telLab.text = [NSString stringWithFormat:@"%@",userName];
        telLab.textAlignment =  NSTextAlignmentCenter;
        telLab.font = [UIFont systemFontOfSize:20.0];
        telLab.textColor = [UIColor whiteColor];
        [bgImg addSubview:telLab];
        
        
    }


    
    return getTopView;
    
}

-(UIView *)addressView
{
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 50)];
    
    UIImageView *shouImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_address.png"]];
    CGRect shou = shouImg.frame;
    shou.origin.x = 15;
    shou.origin.y = 15;
    shouImg.frame = shou;
    [addressView addSubview:shouImg];
    
    
    UILabel *shouLab = [[UILabel alloc]initWithFrame:CGRectMake(shouImg.frame.origin.x + 35, 10, 120, 30)];
    shouLab.text = @"我的收获地址";
    shouLab.font = [UIFont systemFontOfSize:15.0];
    shouLab.textColor = [UIColor colorHexString:@"#333333"];
    [addressView addSubview:shouLab];

    
    return addressView;
    
}

-(UIView *)getItemRow
{
    //外面的大View
     UIView *orderView = [[UIView alloc]initWithFrame:CGRectMake(0,0, zScreenWidth, 85)];
    //4个按钮的view
     UIView *orderBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth-80, 85)];
     [orderView addSubview:orderBtnView];
    
     CGFloat xJiange = (orderBtnView.frame.size.width-4*80)/5;
    
    for (int i=0; i<4; i++)
    {

        
      CGFloat x = xJiange + i%4 *(xJiange +80);
        

      UpImageDownTextBageButton *btn = [[UpImageDownTextBageButton alloc] initWithFrame:CGRectMake(x, 17, 80, 50) ImageName:self.dataArray[i]];
        
        if (_dataArray.count >i)
        {
            [btn setTitle:_array[i].status_name forState:UIControlStateNormal];

            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            
            btn.badgeValue = _array[i].status_count;
            
            btn.tag = 100 + i;
            
           
            
        }
        
        __weak typeof (self)weakSelf = self;
        [btn addTarget:self actionBlock:^(UIButton *sender)
        {
            if (_dataArray[sender.tag - 100])
            {
                
                if ([LonginController isLongin:self completion:nil])
                {
                   
                    OderListController *oderList = [[OderListController alloc]init];
                    oderList.status_id = _array[sender.tag-100].status_id;
                    
                    [weakSelf.navigationController pushViewController:oderList animated:YES];
                    
                }
               
            }
            
        }];
        
        [orderBtnView addSubview:btn];
        
    }
    
    //最右边的view
    UIView *allBtnView = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth-80, 0, 100, 85)];
    [orderView addSubview:allBtnView];
    //箭头的分割线
    UIImageView *fenImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Dividing-line.png"]];
    CGRect fen = fenImg.frame;
    fenImg.frame = fen;
    [allBtnView addSubview:fenImg];
    //右边的大按钮
    UIButton *allOderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allOderBtn.frame = CGRectMake(5, 0, 100, 85);
    [allOderBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [allBtnView addSubview:allOderBtn];
     //全部订单图片
    UIImageView *orderImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_order.png"]];
    CGRect order = orderImg.frame;
    order.origin.x = 20;
    order.origin.y = 23;
    orderImg.frame = order;
    [allOderBtn addSubview:orderImg];
    //右边的标题
    UILabel *allTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, orderImg.frame.size.height+23, 50, 30)];
    allTitle.text = @"全部订单";
    allTitle.font = [UIFont systemFontOfSize:12];
    [allOderBtn addSubview:allTitle];
    
    //右边的小箭头图片
    UIImageView * rightImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right-arrow_little.png"]];
    CGRect  right = rightImg.frame;
    right.origin.x = allTitle.frame.size.width+9;
    right.origin.y = allTitle.frame.origin.y+10;
    rightImg.frame = right;
    [allOderBtn addSubview:rightImg];
    
    
     return orderView;
    
    
}

-(void)allBtnClick:(UIButton *)allBtn
{
    NSLog(@"全部订单按钮点击");
    
    if ([LonginController isLongin:self completion:nil])
    {
        
        OderListController *orderList = [[OderListController alloc]init];
        
        orderList.status_id = @"0";//点击全部订单 的状态就为 0
        
        [self.navigationController pushViewController:orderList animated:YES];
 
        
    }
    
}


-(void)loginClick:(UIButton *)loginBtn
{
    
    [LonginController isLongin:self completion:nil];
    
}

-(NSArray *)dataArray
{
    if (!_dataArray)
    {
        
        NSArray *imgSS = @[@"btn_Pending-payment.png",@"btn_shipped.png",@"btn_Received.png",@"btn_evaluate.png"];
        
        _dataArray = imgSS;
        
    }
    
    return _dataArray;
    
}

-(void)setClick:(UIButton *)setBtn
{
    
    
    if ([LonginController isLongin:self completion:nil])
    {
        
        SettingController *setting = [[SettingController alloc]init];
        
        setting.title = @"设置";
        
        [self.navigationController pushViewController:setting animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
