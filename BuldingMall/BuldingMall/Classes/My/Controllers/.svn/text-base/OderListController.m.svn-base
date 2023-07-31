//
//  OderListController.m
//  BuldingMall
//
//  Created by zfy on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "OderListController.h"
#import "TypeItemView.h"
#import "TypeRemindButton.h"
#import "OrderListViewCell.h"
#import "DetailController.h"
#import "ListModel.h"
#import "PaymentController.h"

#define kOrderListUrl @"OrderList"//我的订单列表的接口

@interface OderListController ()<UITableViewDelegate,UITableViewDataSource,TypeItemViewDelegate,UIAlertViewDelegate>
{
    NSArray * _ttArray;
     UIView   *bgView;
    NSDictionary * dataDic;//登录成功时拿到字典
    NSString *Id;//难道登录字典里面的id
    NSString *statusID;
    
    
}
@property(nonatomic,strong)TypeItemView *typeItemView;
@property(nonatomic,strong)TypeRemindButton *typeRemind;
@property(nonatomic,strong)UITableView *MyTabView;
//@property (retain) MBProgressHUD *HUD;
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation OderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"全部订单";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    
    _ttArray = @[@"11",@"22",@"33",@"44",@"55"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderState) name:@"changeOrder" object:nil];
    
    
    [self setTopNavUI];
    
    
}

-(void)refreshOrderState
{
    [self loadDataOrderListFormServer:kOrderListUrl params:@{@"uid":Id,@"status_id":statusID}];
    
}
//上面5个按钮的View布局
-(void)setTopNavUI
{
    
    _typeItemView = [[TypeItemView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64) Array:_ttArray];
    _typeItemView.backgroundColor = [UIColor whiteColor];
    _typeItemView.delegate = self;
    _typeItemView.selectIndex = [_status_id integerValue];
    [self.view addSubview:_typeItemView];
    
}

#pragma mark--TypeItemViewDelegate
-(void)itemView:(TypeItemView *)itemView didSelectItem:(TypeRemindButton *)item table:(UITableView *)tableView
{
  if (itemView==_typeItemView)
    {
        _typeRemind = item;
        
    }
    
    _MyTabView = tableView;
    _MyTabView.delegate = self;
    _MyTabView.dataSource = self;
//    _MyTabView.backgroundColor = [UIColor purpleColor];
    
     dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
     Id = dataDic[@"id"];
    
    NSLog(@"status_id%@",self.status_id);
    statusID = [NSString stringWithFormat:@"%ld",item.tag];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadDataOrderListFormServer:kOrderListUrl params:@{@"uid":Id,@"status_id":statusID}];
    });
    
    
    //yn coding 10月21号
    
    _MyTabView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerreshing)];
    
    
    
    
}

-(void)headerreshing
{
    
     [self loadDataOrderListFormServer:kOrderListUrl params:@{@"uid":Id,@"status_id":statusID}];
    
}

//主列表的请求数据
-(void)loadDataOrderListFormServer:(NSString *)url params:(NSDictionary *)param
{

    //第一个待付款按钮触发的列表请求数据
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:self response:^(id json)
     {
         
         //添加刷新代码
         [_MyTabView.header endRefreshing];
         
         
         NSLog(@"我的列表%@",json);
         
         NSArray *resultArray = (NSArray *)json;
         
         if ([url isEqualToString:kOrderListUrl])
         {
             [self arrangeDataListOrder:resultArray];
             
         }
         
         
     } error400Code:^(id failure)
     {
         [_MyTabView.header endRefreshing];
         
     }];
    
    
    
}

//第一个按钮触发的请求数据格式
-(void)arrangeDataListOrder:(NSArray *)resultArray
{
    if (resultArray.count == 0)
    {
        [_dataArray removeAllObjects];
        [self nilView];
        
        
    }
    else
    {
        if (bgView)
        {
            [bgView removeFromSuperview];
             bgView = nil;
            
        }
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dict in resultArray)
        {
            ListModel *model = [ListModel initListWithDict:dict];
            
            [tempArray addObject:model];
            
        }
        
        _dataArray = tempArray;
        


    }
    
    [_MyTabView reloadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
    
}
//在某个区 返回多少行
#pragma mark--tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",_dataArray.count);
    
    return _dataArray.count;
    
}

 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ListCell";
    
    OrderListViewCell *cell;
    
    cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"OrderListViewCell" owner:nil options:nil];
        cell = [xibArray objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //调用方法，给单元格赋值
    
    [cell addTheValue:_dataArray[indexPath.row]];
    
    //是待付款的状态点击列表的按钮，跳转到支付的界面中去
    cell.nav = self.navigationController;
    
    //删除订单或者确认订单之后重新请求，刷新一下界面
    cell.delCellBack = ^()
    {
        [self loadDataOrderListFormServer:kOrderListUrl params:@{@"uid":Id,@"status_id":statusID}];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOrder" object:nil userInfo:nil];
        
    };

    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        DetailController *detail = [[DetailController alloc]init];
    
        ListModel *model = [_dataArray objectAtIndex:indexPath.row];
    
        detail.orderId = model.Id;
    
        detail.detailCallBack = ^(NSString *str)
       {
           
         [self loadDataOrderListFormServer:kOrderListUrl params:@{@"uid":Id,@"status_id":statusID}];
           
           [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOrder" object:nil userInfo:nil];
        
       };
    
        [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark--当没有数据时显示的界面
- (void)nilView{
    if (!bgView){
        bgView = [[UIView alloc]initWithFrame:_MyTabView.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        
        UIImageView *nilimage = [[UIImageView alloc]init];
        
        if (iPhone4)
        {
            nilimage.frame = CGRectMake(zScreenWidth/2-30, 140, 60, 60);
            
        }
        else
        {
            nilimage.frame = CGRectMake(zScreenWidth/2-30, 200, 60, 60);
            
        }
        
//        UIImageView *nilimage = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-30, 200, 60, 60)];
        
        nilimage.image = [UIImage imageNamed:@"btn_no-order.png"];
        [bgView addSubview:nilimage];
        
        
        UILabel *nilLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nilimage.frame), zScreenWidth, 50)];
        nilLabel.textAlignment = NSTextAlignmentCenter;
        nilLabel.text = @"您还没有相关订单";
        nilLabel.font = [UIFont boldSystemFontOfSize:21.0];
        nilLabel.textColor = [UIColor colorHexString:@"#808080"];
        [bgView addSubview:nilLabel];
    }
    
    [_MyTabView addSubview:bgView];
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
