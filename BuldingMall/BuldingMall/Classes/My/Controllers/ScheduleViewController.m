//
//  ScheduleViewController.m
//  BuldingMall
//
//  Created by noise on 16/9/21.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SectionHeaderView.h"
#import "MyTableViewCell.h"
#import "HTTPRequest.h"
#import "NodeModel.h"
#import "NodeModelB.h"
#import "NodeNoteModel.h"
#import "TipWebViewController.h"

@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NodeModelB *modelB;
    NSMutableArray *tempArr;
    NSMutableArray *tempArrnote;
    NodeModel *model1;
    NodeNoteModel *notemodel;
}


@property (nonatomic,strong) NSMutableDictionary *dicData;

@property (nonatomic,strong) NSMutableDictionary *isOpen;

@property (nonatomic,strong) NSMutableDictionary *indexPathDic;

@property (retain) MBProgressHUD *HUD;

@end

static NSString *const cellID = @"cellID";

@implementation ScheduleViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"进度详情";
    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
    NSString *userid = [obj valueForKey:@"id"];
    
    NSDictionary *dic = @{@"user_id":userid,@"order_id":_ID,@"goods_id":_DModel.gid};
    NSLog(@"%@",dic);
    
//    NSDictionary *dic1 = @{@"user_id":@"1244",@"order_id":@"5168",@"goods_id":@"29"};
//    NSLog(@"%@",dic);
    
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:@"GetNodeTemplate" params:dic ProgressHUD:self.HUD controller:self response:^(id json) {
        NSLog(@"111111");
        NSLog(@"%@",json);
        NSDictionary *result = (NSDictionary *)json;
        NSLog(@"2222222");
        NSLog(@"%@",result);
        modelB = [NodeModelB initNodeBWithDict:result];
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:modelB.info];
        NSLog(@"33333333");
        NSLog(@"%@",arr);
        tempArr = [NSMutableArray array];
        for (id dict in arr) {
            model1 = [NodeModel initNodeWithDict:dict];

            [tempArr addObject:model1];
            
        }
        
        [self customUI];
        [self setGroupData];

    } error400Code:^(id failure) {
        
        UIView *shview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
        shview.backgroundColor = [UIColor colorHexString:@"ffffff"];
        UIImageView *imagesh = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-42.5, 95, 85, 86)];
        imagesh.contentMode = UIViewContentModeCenter;
        imagesh.image = [UIImage imageNamed:@"btn_sh.png"];
        UILabel *shlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, zScreenWidth-30,zScreenHeight-200)];
        shlabel.font = [UIFont boldSystemFontOfSize:21];
        shlabel.textColor = [UIColor colorHexString:@"808080"];
        shlabel.textAlignment = NSTextAlignmentCenter;
        shlabel.numberOfLines = 0;
        shlabel.text = @"专业人员正在对您所购买的商品及邮寄地址等信息进行审核，审核成功后，系统自动显示订单进度哦";
        [shview addSubview:imagesh];
        [shview addSubview:shlabel];
        
        [self.view addSubview:shview];
    }];
    
    
    
    [super viewDidLoad];
    
//    [self customUI];
//    [self setGroupData];
}

- (void)customUI
{


    UIView *zdview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    zdview.backgroundColor = [UIColor colorHexString:@"ffffff"];
    UIImageView *imagezd = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-45.5, 95, 91, 85)];
    imagezd.contentMode = UIViewContentModeCenter;
    imagezd.image = [UIImage imageNamed:@"btn_zd1.png"];
    UILabel *zdlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, zScreenWidth-30, zScreenHeight-200)];
    zdlabel.font = [UIFont boldSystemFontOfSize:21];
    zdlabel.textColor = [UIColor colorHexString:@"808080"];
    zdlabel.textAlignment = NSTextAlignmentCenter;
    zdlabel.numberOfLines = 0;
    
    NSString *fllow = modelB.fllow_time;
    
    NSString *node = modelB.first_node;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"暂约%@%@，客服会提前跟您联系，确认时间如有变动请提前说明哦",fllow,node]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,fllow.length+node.length)];
    zdlabel.attributedText = str;
    
    
    [zdview addSubview:imagezd];
    [zdview addSubview:zdlabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, zScreenWidth, zScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 79;
    self.tableView.sectionHeaderHeight = 71;
    
    self.view.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    
    if (modelB.fllow_time && !modelB.first_node_set_time) {
        [self.view addSubview:zdview];
    }else if (modelB.first_node_set_time && modelB.fllow_time){
        [self.view addSubview:self.tableView];
    }
    
}



#pragma mark 设置分组数据,分组效果需要对数据结构有较深的理解。
- (void)setGroupData
{

    self.dicData = [NSMutableDictionary dictionary];
    
    self.indexPathDic = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0 ; i < tempArr.count; i++) {
        
        NodeModel *nodemodel = tempArr[i];
        
//        NSDictionary *dic = self.dataSource[i];
        
        [self.dicData setValue:nodemodel.note forKey:[NSString stringWithFormat:@"section%zi",i]];
        
        NSArray *cellArr = nodemodel.note;
        
        NSMutableArray *indexPathArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i < cellArr.count; i ++) {
            
            [indexPathArr addObject:[NSNumber numberWithBool:YES]];
        }
        
        [self.indexPathDic setValue:indexPathArr forKey:[NSString stringWithFormat:@"indexPathArr%zi",i]];
        
    }
    
    self.isOpen = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0; i < self.dicData.allKeys.count; i++) {
        
        
        [self.isOpen setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"section%zi",i]];
        
    }
    
    
    [self.tableView reloadData];
    
    
}

#pragma mark tableViewDalegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cellArr = [self.dicData objectForKey:[NSString stringWithFormat:@"section%zi",section]];
    BOOL isOpen = [[self.isOpen objectForKey:[NSString stringWithFormat:@"section%zi",section]]boolValue];
    
    return isOpen ? cellArr.count : 0;

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tempArr.count;

    
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionHeaderView *headerView = [SectionHeaderView headerViewWithTableView:tableView];
    
    NSMutableArray *sarr = [NSMutableArray array];//node
    NSMutableArray *tarr = [NSMutableArray array];//node_type
    NSMutableArray *darr = [NSMutableArray array];//day
    NSMutableArray *parr = [NSMutableArray array];//remark
    NSMutableArray *ptarr = [NSMutableArray array];//plan time
    NSMutableArray *staarr = [NSMutableArray array];//status
    NSMutableArray *sstaarr = [NSMutableArray array];//done
    NSMutableArray *tipsarr = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < tempArr.count; i++){
        NodeModel *nodeModel = tempArr[i];
        NSDictionary *dic = nodeModel.node_tips;
        [sarr addObject:nodeModel.node];
        [tarr addObject:nodeModel.node_type];
        [darr addObject:nodeModel.day];
        [ptarr addObject:nodeModel.plan_date];
        [sstaarr addObject:nodeModel.done];
        [parr addObject:[dic valueForKey:@"remark"]];
        [staarr addObject:[dic valueForKey:@"status"]];
        [tipsarr addObject:nodeModel.tips];
    }
//    headerView.ProView.image = [UIImage imageNamed:@"btn_tx4.png"];
    
    if ([sstaarr[section] integerValue] == 0) {
        headerView.Prolabel.text = @"未开始";
        headerView.button.hidden = YES;
        headerView.ProView.image = [UIImage imageNamed:@"btn_tx4.png"];
        headerView.imgView.image = [UIImage imageNamed:@"btn_wks.png"];
    }else if ([sstaarr[section] integerValue] == 1){
         headerView.Prolabel.text = parr[section];
//        headerView.Prolabel.text = @"已完成";
        headerView.imgView.image = [UIImage imageNamed:@"btn_ywc"];
        headerView.button.hidden = YES;
        if ([staarr[section] integerValue] == 0) {
            headerView.ProView.image = [UIImage imageNamed:@"btn_tx2.png"];
        }else if ([staarr[section] integerValue] == 1){
            headerView.ProView.image = [UIImage imageNamed:@"btn_tx2.png"];
        }else if([staarr[section] integerValue] == 2){
            headerView.ProView.image = [UIImage imageNamed:@"btn_tx1.png"];
        }
    }else if([sstaarr[section] integerValue] == 2){
        if ([tipsarr[section]  isEqual: @""]) {
            headerView.button.hidden = YES;
        }
        headerView.Prolabel.text = @"进行中";
        headerView.ProView.image = [UIImage imageNamed:@"btn_tx3.png"];
        headerView.imgView.image = [UIImage imageNamed:@"btn_jxz.png"];
    }
    
    headerView.seclabel.text = sarr[section];

    
    if (modelB.first_node_set_time) {
        headerView.timelable.text = ptarr[section];
    }else{
        headerView.timelable.text = [NSString stringWithFormat:@"%@%@天内",tarr[section],darr[section]];
    }
//    headerView.Prolabel.text = parr[section];
//    UIButton *isOpenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    isOpenBtn.frame = CGRectMake(0, 0,self.view.frame.size.width, 71);
//    isOpenBtn.tag = section;
//    [headerView addSubview:isOpenBtn];
    headerView.bigbutton.tag = section;
    headerView.button.tag = section;
    
    [headerView.bigbutton addTarget:self action:@selector(isOpen:) forControlEvents:UIControlEventTouchUpInside];
    headerView.bigbutton.showsTouchWhenHighlighted = NO;
    
    
    [headerView.button addTarget:self action:@selector(sendweb:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
    
}

- (void)isOpen:(UIButton *)sender
{
    BOOL isOpen = [[self.isOpen objectForKey:[NSString stringWithFormat:@"section%zi",sender.tag]] boolValue];
    [self.isOpen setValue:[NSNumber numberWithBool:!isOpen] forKey:[NSString stringWithFormat:@"section%zi",sender.tag]];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.stateLabel.textColor = [UIColor colorHexString:@"25ae5f"];
        cell.timeLabel.textColor = [UIColor colorHexString:@"25ae5f"];
        cell.headImg.image = [UIImage imageNamed:@"btn_jd1.png"];
    }else{
        cell.stateLabel.textColor = [UIColor colorHexString:@"cccccc"];
        cell.timeLabel.textColor = [UIColor colorHexString:@"cccccc"];
        cell.headImg.image = [UIImage imageNamed:@"btn_jd2.png"];
    }
    
    NodeModel *model = tempArr[indexPath.section];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:model.note];
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (dic in arr) {
        NodeNoteModel *nodenotemodel = [NodeNoteModel initNodeNoteWithDict:dic];
        [arr1 addObject:nodenotemodel];
    }
    NodeNoteModel *data = arr1[indexPath.row];
    cell.stateLabel.text = data.note;
    cell.timeLabel.text = data.created;
    

    
    return cell;
}

-(void) sendweb:(UIButton *)sender{
    NSLog(@"sendweb");
    NodeModel *wModel = tempArr[sender.tag];
    TipWebViewController * vc = [TipWebViewController alloc];
    NSURL *surl = [NSURL URLWithString:wModel.url_tips];
    
    vc.url = surl;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
