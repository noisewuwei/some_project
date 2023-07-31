//
//  ShippAddressController.m
//  BuldingMall
//
//  Created by zfy on 16/9/12.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ShippAddressController.h"
#import "AdressCell.h"
#import "UpdateAddressController.h"
#import "AdressModel.h"
#import "HTTPRequest.h"
#import "ZJStoreDefaults.h"

@interface ShippAddressController (){
    
    NSMutableArray *tempArr;
    NSDictionary *dic;
    
    
}
@property (retain) MBProgressHUD *HUD;
@property(nonatomic,strong) UIButton *addbtn;
@end

@implementation ShippAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];

    NSString *userid = [obj valueForKey:@"id"];

    
     dic = @{@"uid":userid};
//    [HTTPRequest postWithURL:@"AddressList" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
//        NSArray *resultArray = (NSArray *)json;
//        tempArr = [NSMutableArray array];
//        for (NSDictionary *dict in resultArray) {
//            AdressModel *model = [AdressModel initAdressWithDict:dict];
//            [tempArr addObject:model];
//        }
//        [self.tableView reloadData];
//    } error400Code:^(id failure) {
//        
//    }];
    
    [self loadDataAddressListDateFormSever:@"AddressList" params:dic];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _addbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-50-64, zScreenWidth, 50)];
    _addbtn.backgroundColor = [UIColor redColor];
    [_addbtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    _addbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_addbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_addbtn addTarget:self action:@selector(addclick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:_addbtn];
}

-(void)loadDataAddressListDateFormSever:(NSString *)url params:(NSDictionary *)param
{
    [self.HUD show:YES];
    
    [HTTPRequest postWithURL:@"AddressList" params:dic ProgressHUD:self.HUD controller:self response:^(id json) {
        NSArray *resultArray = (NSArray *)json;
        tempArr = [NSMutableArray array];
        for (NSDictionary *dict in resultArray) {
            AdressModel *model = [AdressModel initAdressWithDict:dict];
            [tempArr addObject:model];
        }
        [self.tableView reloadData];
    } error400Code:^(id failure) {
        
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerID = @"headerID";
    UITableViewHeaderFooterView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    if (headview == nil) {
        headview = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerID];
        headview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    }
    return headview;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"Cell";
    AdressCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[AdressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    AdressModel *model1 = [tempArr objectAtIndex:indexPath.row];
    NSLog(@"%@",model1.Id);
    
    cell.nameLabel.text = model1.receive_name;
    cell.numLabel.text = model1.mobile;
    cell.adressLabel.text = [NSString stringWithFormat:@"%@%@%@",model1.city,model1.district,model1.address];
    cell.adressButton.selected = [model1.is_default integerValue]; //== 1 ?YES:NO;

    [cell.editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButton.tag = 1000+indexPath.row;
    [cell.adressButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    cell.adressButton.tag = 1000+indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = 1000+indexPath.row;
    
    cell.tag = indexPath.row;
    
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AdressModel *selectmodel = [tempArr objectAtIndex:indexPath.row];

    if(self.addressCallBack){
        self.addressCallBack(selectmodel);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)edit:(UIButton *)editBtn
{
    
    AdressModel *amodel = [tempArr objectAtIndex:editBtn.tag-1000];
    
    UpdateAddressController *vc = [UpdateAddressController alloc];
    vc.ressModel = amodel;
    
    vc.detailCallBack = ^(NSString *str)
    {
        [self loadDataAddressListDateFormSever:@"AddressList" params:dic];
    };

    vc.title = @"编辑收货地址";
    
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"edit");
    
    
}

- (void)select:(UIButton *)selectBtn{
    selectBtn.selected = !selectBtn.selected;
    NSArray *visibleCells = [self.tableView visibleCells];
    for (AdressCell *cell in visibleCells) {
        
        if (cell.tag == selectBtn.tag - 1000) {
            
            AdressModel *model = [tempArr objectAtIndex:cell.tag];
            
            id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
            
            NSString *userid = [obj valueForKey:@"id"];
            
            NSDictionary *dicc = @{@"uid":userid,@"id":model.Id};
            
            [self.HUD show:YES];
            
            [HTTPRequest postWithURL:@"setDefault" params:dicc ProgressHUD:self.HUD controller:self response:^(id json) {
                id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
                NSString *userid = [obj valueForKey:@"id"];
                NSDictionary *dicc = @{@"uid":userid};
                
                [self.HUD show:YES];
                
                [HTTPRequest postWithURL:@"AddressList" params:dicc ProgressHUD:self.HUD controller:self response:^(id json) {
                    
                    NSArray *resultArray = (NSArray *)json;
                    tempArr = [NSMutableArray array];
                    for (NSDictionary *dict in resultArray) {
                        AdressModel *model = [AdressModel initAdressWithDict:dict];
                        [tempArr addObject:model];
                    }
                    [self.tableView reloadData];
                } error400Code:^(id failure) {
                    
                }];
            
            } error400Code:^(id failure) {
                
            }];
            break;
        }
        
    }
    

//   [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        AdressModel *model = (AdressModel*)obj;
//        if ([model.is_default isEqual:@1]) {
//            model.is_default = @0;
//            *stop = YES;
//        }
//    }];
//   AdressModel *amodel = [tempArr objectAtIndex:selectBtn.tag - 1000];
//    [amodel setIs_default:selectBtn.selected?@1:@0];
//    
//    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
//    NSString *userid = [obj valueForKey:@"id"];
//    NSDictionary *dic = @{@"uid":userid,@"id":amodel.Id};
//    [HTTPRequest postWithURL:@"setDefault" params:dic ProgressHUD:_HUD controller:self response:^(id json) {
//        
//    } error400Code:^(id failure) {
//        
//    }];
//    
//
//    [self.tableView reloadData];
}

- (void)delete:(UIButton *)deleteBtn{
    
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除该地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertview show];
    
    alertview.tag = deleteBtn.tag;
    
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSArray *visibleCells = [self.tableView visibleCells];
        for (AdressCell *cell in visibleCells) {
            if (cell.tag == alertView.tag - 1000) {
                AdressModel *model = [tempArr objectAtIndex:cell.tag];
                
                id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
                
                NSString *userid = [obj valueForKey:@"id"];
                
                NSDictionary *dicc = @{@"uid":userid,@"id":model.Id};
                
                
                [HTTPRequest postWithURL:@"AddressDelete" params:dicc ProgressHUD:self.HUD controller:self response:^(id json) {
                    id obj = [ZJStoreDefaults getObjectForKey:LoginSucess];
                    NSString *userid = [obj valueForKey:@"id"];
                    NSDictionary *dicc = @{@"uid":userid};
                    
                    [self.HUD show:YES];
                    
                    [HTTPRequest postWithURL:@"AddressList" params:dicc ProgressHUD:self.HUD controller:self response:^(id json) {
                        
                        NSArray *resultArray = (NSArray *)json;
                        tempArr = [NSMutableArray array];
                        for (NSDictionary *dict in resultArray) {
                            AdressModel *model = [AdressModel initAdressWithDict:dict];
                            [tempArr addObject:model];
                        }
                        [self.tableView reloadData];
                    } error400Code:^(id failure) {
                        
                    }];
                    
                } error400Code:^(id failure) {
                    
                }];
                break;
            }
            
        }
    }
}

- (void)addclick{
    NSLog(@"addAdress");
    
    UpdateAddressController *vc = [UpdateAddressController alloc];
    vc.detailCallBack = ^(NSString *str)
    {
        [self loadDataAddressListDateFormSever:@"AddressList" params:dic];
    };
    
    vc.title = @"添加收货地址";
    
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"edit");

}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"back");
    }];
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
