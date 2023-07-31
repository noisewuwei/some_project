//
//  UpdateAddressController.m
//  BuldingMall
//
//  Created by zfy on 16/9/14.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "UpdateAddressController.h"
#import "ChooseAddressView.h"
#import "AddressAddModel.h"

#define kAddressListUrl @"getAddress"//获取地址区域的接口
#define kAddressOkUrl   @"AddressSave"//1.1.8	添加或修改地址
@interface UpdateAddressController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITableView *myTab;
    UITextField *nameTF;//收货人的姓名
    UITextField *telTF;//收货人的电话
    UITextField *addressTF;//填写收货地址
    UITextField *choessTF;//选择区域
    UILabel *Arress1;
    UILabel *Arress2;
    NSString *str;
    ChooseAddressView *chooseAddress;
    NSDictionary * dataDic;
    NSString *Id;
    AddressAddModel *model;
    
    NSString *district_id;
    
    NSString *OnisDefault;
    UISwitch *swch;
    
    
}
@property (nonatomic, strong) UIControl *controlForDismiss;
@property (nonatomic,strong)NSMutableArray *rightArray;
@end

@implementation UpdateAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"address%@",self.AddressId);
    
    
    self.view.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, zScreenHeight-110, zScreenWidth, 50);
    okBtn.backgroundColor = [UIColor redColor];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    _sectionTitleArr = [[NSArray alloc]initWithObjects:@"联系人",@"收货地址", nil];
    _rowTitleArr = [[NSArray alloc]initWithObjects:@"姓名:", @"手机:",nil];
    _rowTwoArr = [[NSArray alloc]initWithObjects:@"所在地区:",@"详细地址:", nil];
    
     [self createTab];
    
    _LeftArr=@[@"上海"];
    
    
    NSLog(@"add%@",self.AddressId);
    
    dataDic = [ZJStoreDefaults getObjectForKey:LoginSucess];
    Id = dataDic[@"id"];
    
    
    
}



-(void)createTab
{
    myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-50) style:UITableViewStyleGrouped];
    myTab.delegate = self;
    myTab.dataSource = self;
    
//    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self.view addSubview:myTab];
    
    
}
//返回多少个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
//在某个区中 返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 1;
        
    }
    else
    {
        return 2;
        
    }
    
}
//配置单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellInentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //一下判断就是可以让第一个区的第一行点击其余的不能点击
    
    if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    
    if (indexPath.section==2)
    {
        UILabel *isArress = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 120, 30)];
        isArress.font = [UIFont systemFontOfSize:16.0];
        isArress.textColor = [UIColor colorHexString:@"#333333"];
        isArress.text = @"设为默认地址";
        [cell.contentView addSubview:isArress];
        
        swch = [[UISwitch alloc]initWithFrame:CGRectMake(zScreenWidth-75, 7, 30, 60)];
        
       
        
        NSLog(@"_ressModel.is_default%@",_ressModel.is_default);

        NSString *isdefault = [NSString stringWithFormat:@"%@",_ressModel.is_default];
        
        if (_ressModel.Id == nil)
        {
            [swch setOn:NO];
        }
        else
        {
            if ([isdefault isEqualToString:@"0"])
            {
                
                [swch setOn:NO];
                
            }
            else if([isdefault isEqualToString:@"1"])
            {
                [swch setOn:YES];
                
            }
            else
            {
                [swch setOn:NO];
                
            }

            
        }
        
        
        [swch addTarget:self action:@selector(onChangeAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:swch];
        
        
        
    }
    else if(indexPath.section==1)
    {
        Arress2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 120, 30)];
        Arress2.font = [UIFont systemFontOfSize:16.0];
        Arress2.textColor = [UIColor colorHexString:@"#333333"];
//        Arress.text = [[_rowTitleArr objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
        Arress2.text = [_rowTwoArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:Arress2];
        
        if (indexPath.row==0)
        {
            //实现右边的箭头
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([cell viewWithTag:888])
            {
                [[cell viewWithTag:888] removeFromSuperview];
                
            }
            UIView *chooseView = [self chooseView];//布局cell所在的区域的view

            chooseView.tag = 888;
            [cell.contentView addSubview:chooseView];

            
        }
        else
        {
            
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([cell viewWithTag:999])
            {
                [[cell viewWithTag:999] removeFromSuperview];
                
            }
            UIView *addressView = [self addressView];//布局显示cell上面的详细地址的view
            addressView.tag = 999;
            [cell.contentView addSubview:addressView];

            
        }
        
        
        
  

    }
    else
    {
        Arress1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 120, 30)];
        Arress1.font = [UIFont systemFontOfSize:16.0];
        Arress1.textColor = [UIColor colorHexString:@"#333333"];
        Arress1.text = [_rowTitleArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:Arress1];
        
        if (indexPath.row==0)
        {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            if ([cell viewWithTag:666])
            {
                [[cell viewWithTag:666] removeFromSuperview];
                
            }
            UIView *nameView = [self getNameView];//布局显示cell收货人的名字的view
            nameView.tag = 666;
            [cell.contentView addSubview:nameView];
            
            
            
        }
        else
        {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            if ([cell viewWithTag:777])
            {
                [[cell viewWithTag:777] removeFromSuperview];
                
            }
            UIView *telView = [self telView];//布局显示cell收货手机号码的view
            telView.tag = 777;
            [cell.contentView addSubview:telView];
            
        }

        

    }
    
    return cell;
    
    
}
//布局显示cell收货人的名字的view
-(UIView *)getNameView
{
    
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(Arress1.frame.origin.x + 70, 8, zScreenWidth-150, 30)];
    nameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, nameView.frame.size.width, 30)];
    nameTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIColor *hocolor = [UIColor colorHexString:@"#808080"];
    nameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请填写收货人的姓名" attributes:@{NSForegroundColorAttributeName: hocolor}];
    
    if (_ressModel.Id == nil)
    {
        NSLog(@"添加地址");
    }
    else
    {
      nameTF.text = [NSString stringWithFormat:@"%@",_ressModel.receive_name];//显示编辑的信息地址数据
        
    }
    

    nameTF.textColor = [UIColor colorHexString:@"#333333"];
    nameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    nameTF.returnKeyType=UIReturnKeyDone;
    nameTF.font = [UIFont systemFontOfSize:16.0];
    nameTF.autocapitalizationType=UITextAutocapitalizationTypeNone;
    nameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTF.delegate=self;
    [nameView addSubview:nameTF];
    
    return nameView;
    

    
}
//布局显示cell收货手机号码的view
-(UIView *)telView
{
        UIView  *telView = [[UIView alloc]initWithFrame:CGRectMake(Arress1.frame.origin.x+70, 8, zScreenWidth-150, 30)];
        telTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, telView.frame.size.width, 30)];
        telTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        UIColor *hocolor = [UIColor colorHexString:@"#808080"];
        telTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请填写收货手机号码" attributes:@{NSForegroundColorAttributeName: hocolor}];
    
    if (_ressModel.Id == nil)
    {
        NSLog(@"添加地址");
    }
    else
    {
       telTF.text = [NSString stringWithFormat:@"%@",_ressModel.mobile];//显示编辑的信息地址数据
        
    }

        telTF.textColor = [UIColor colorHexString:@"#333333"];
        telTF.clearButtonMode=UITextFieldViewModeWhileEditing;
        telTF.returnKeyType=UIReturnKeyDone;
        telTF.font = [UIFont systemFontOfSize:16.0];
        telTF.autocapitalizationType=UITextAutocapitalizationTypeNone;
        telTF.autocorrectionType = UITextAutocorrectionTypeNo;
        telTF.delegate=self;
        [telView addSubview:telTF];
    
        return telView;
    
    

    
}

//布局cell所在的区域的view
-(UIView *)chooseView
{

    UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(Arress2.frame.origin.x+75, 8, zScreenWidth-100, 30)];
    
    
    choessTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, chooseView.frame.size.width, 30)];
    choessTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIColor *hocolor = [UIColor colorHexString:@"#808080"];
    choessTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请选择所在的地区" attributes:@{NSForegroundColorAttributeName: hocolor}];
    choessTF.text = _ressModel.district;
    choessTF.textColor = [UIColor colorHexString:@"#333333"];
    choessTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    choessTF.returnKeyType=UIReturnKeyDone;
    choessTF.font = [UIFont systemFontOfSize:16.0];
    choessTF.autocapitalizationType=UITextAutocapitalizationTypeNone;
    choessTF.autocorrectionType = UITextAutocorrectionTypeNo;
    choessTF.enabled = NO;
    [chooseView addSubview:choessTF];
    
    return chooseView;
    
    
}
//布局显示cell上面的详细地址的view
-(UIView *)addressView
{
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(Arress2.frame.origin.x+75, 8, zScreenWidth-100, 30)];
    
    addressTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, addressView.frame.size.width, 30)];
    addressTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIColor *hocolor = [UIColor colorHexString:@"#808080"];
    addressTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请填写详细地址" attributes:@{NSForegroundColorAttributeName: hocolor}];
    if (_ressModel.Id == nil)
    {
        NSLog(@"添加地址");
    }
    else
    {
        addressTF.text = [NSString stringWithFormat:@"%@",_ressModel.address];//显示编辑的信息地址数据
        
    }

    addressTF.textColor = [UIColor colorHexString:@"#333333"];
    addressTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    addressTF.delegate = self;
    addressTF.returnKeyType=UIReturnKeyDone;
    addressTF.font = [UIFont systemFontOfSize:16.0];
    addressTF.autocapitalizationType=UITextAutocapitalizationTypeNone;//首字母是否大写
    addressTF.autocorrectionType = UITextAutocorrectionTypeNo;//是否纠错
    [addressView addSubview:addressTF];
    
    return addressView;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            NSLog(@"弹出pickView");
            
            chooseAddress = [ChooseAddressView instanceNewAddressView];
            
            if (zScreenWidth<375)
            {
                
//            chooseAddress.bounds = CGRectMake(0, 0, chooseAddress.bounds.size.width*zScreenWidth/375.0, chooseAddress.bounds.size.height);
                
            chooseAddress.frame = CGRectMake(0, zScreenHeight-200, zScreenWidth, 200);
 
                
            }
            
            chooseAddress.AddPickVIew.delegate = self;
            chooseAddress.AddPickVIew.dataSource = self;
            
            [self loadDataAddressListFormSever:kAddressListUrl params:@{@"uid":Id}];
            
            
            [chooseAddress showViewInControl];

            
            [chooseAddress.OkBtn addTarget:self action:@selector(OKbtnCkick:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
    }
}

-(void)onChangeAction:(UISwitch *)sender
{
    NSLog(@"改变开关按钮");
    
    if (sender.on==YES)
    {
        NSLog(@"开关开着");
        
       OnisDefault = [NSString stringWithFormat:@"1"];
        
        
        
    }
    else
    {
        NSLog(@"开关关着");
        
      OnisDefault = [NSString stringWithFormat:@"0"];
        
        
    }
}
//区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2)
    {
        return 15;
        
    }
    else
    {
         return 42;
        
    }
    
    
}
//区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

//自定义区头view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionHeaderView = [[UIView alloc]init];
    
    if (section==2)
    {
        sectionHeaderView.frame = CGRectMake(0, 0, zScreenWidth, 15);
        
    }
    else
    {
        
        sectionHeaderView.frame = CGRectMake(0, 0, zScreenWidth, 42);
        sectionHeaderView.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
        
        UILabel *beiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 30)];
        beiLab.text = [_sectionTitleArr objectAtIndex:section];
        beiLab.font = [UIFont systemFontOfSize:15.0];
        beiLab.textColor = [UIColor colorHexString:@"#4c4c4c"];
        [sectionHeaderView addSubview:beiLab];
        
    }
    
    
    
    
    return sectionHeaderView;
    
}
//自定义区尾view
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *setionFooterView = [[UIView alloc]init];
    
    return setionFooterView;
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (nameTF==textField || telTF==textField || addressTF==textField)
    {
        [nameTF resignFirstResponder];
        [telTF resignFirstResponder];
        
        addressTF.allowsEditingTextAttributes = YES;
        
        [addressTF resignFirstResponder];
        
        
    }
    
    return YES;
}
//点击详细地址 将表的y轴向上移动 zScreenHeight-zNavigationHeight-50
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (iPhone4)
    {
        if (addressTF == textField)
        {
            myTab.frame = CGRectMake(0, -110, zScreenWidth, zScreenHeight-zNavigationHeight-50);
            
        }
    }
    
}
//点击详细地址 将表的y轴输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (addressTF == textField)
    {
        myTab.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-50);
        
    }
}

-(void)loadDataAddressListFormSever:(NSString *)url params:(NSDictionary *)param
{
//    [self.HUD show:YES];
    
    //第一个待付款按钮触发的列表请求数据
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:self response:^(id json)
     {
         
         NSLog(@"我的地址列表数据%@",json);
         
         NSDictionary *dateDic = [NSDictionary dictionaryWithDictionary:json];
         
                  //从大字典里面取出小字典
        NSMutableDictionary *_dic = [NSMutableDictionary dictionaryWithDictionary:[dateDic objectForKey:@"cities"]];
        //从大字典里面取出数组字段名
        NSLog(@"_dic%@",_dic);
         
        NSMutableArray *allDistriceArr = [dateDic objectForKey:@"districts"];
        NSLog(@"所有区的数组%ld",allDistriceArr.count);
         
        NSMutableArray *provincesArr = [dateDic objectForKey:@"provincies"];
        NSLog(@"所有省份的数组%ld",provincesArr.count);
         
        if ([url isEqualToString:kAddressListUrl])
        {
            
            [self arrangeDataListOrder:allDistriceArr];
                      
                      
        }
         

         
     } error400Code:^(id failure)
     {
         
     }];
    
    
}

//所有区对应的区名以及区的id以及城市的id
-(void)arrangeDataListOrder:(NSMutableArray *)resultArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSDictionary *dict in resultArray)
    {
        model = [AddressAddModel initWithDict:dict];
        
        [tempArray addObject:model];
        
    }
    
    _rightArray = tempArray;
    
    [chooseAddress.AddPickVIew reloadAllComponents];
    
    //默认是选中时，为了得到默认的区以及市
    [self  pickerView:chooseAddress.AddPickVIew didSelectRow:0 inComponent:1];
    
    
}


//设置pickView的分组 就是一共几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 2;
    
}
//每一列有多少数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return [_LeftArr count];
    }
    else
    {

        NSLog(@"_ringggggggggt%ld",_rightArray.count);

        return [ _rightArray count];
        
        
    }
    
    
}
//设置左右的标题 每次调用此方法会传过来两个值，分别为当前设置的哪个组，哪个行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [_LeftArr objectAtIndex:row];
        
    }
    
    
      model = [_rightArray objectAtIndex:row];
    
    NSLog(@"%@",model.district_name);
    
   return model.district_name;
    
    
    
}
#pragma mark - UIPickerViewDelegate  对文字进行设置大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    NSLog(@"dfdkjfkdjfkdjf%@",pickerLabel.text);
    
    return pickerLabel;
}

//当前选择的时哪个组的哪一行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //获取左边选中的内容，因为此时参数component = 0,所以参数row就为左边选中的行数
    if (component==0)
    {
        NSString *lstr = [_LeftArr objectAtIndex:row];
        
        NSInteger row1 = [pickerView selectedRowInComponent:1];
        //通过右边选中的行数获取右边选中的内容
        
//        NSString *rstr = [_rightArray objectAtIndex:row1];
        model = [_rightArray objectAtIndex:row1];
        NSString *rstr = [NSString stringWithFormat:@"%@",model.district_name];
         NSString *sztr = [NSString stringWithFormat:@"左边数组中的内容为：%@,右边数组中的内容为：%@",lstr,rstr];
        NSLog(@"地区为%@",sztr);
        
        
    }
    else//表示此时波动的是右边的分组
    {
        
         model = [_rightArray objectAtIndex:row];
        
        //获取右边选中的内容，因为此时参数component=1,所以参数row就为右边选中的行数
//         NSString *rstr = [_rightArray objectAtIndex:row];
        NSString *rstr = [NSString stringWithFormat:@"%@",model.district_name];
        
         //先获取左边选中的行数（因为此时右边在波动，无法直接获取左边选中的行数，pickerView调用selectedRowInComponent:0 就可以获取左边选中的行数）
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        
        NSString *lstr = [_LeftArr objectAtIndex:row1];
        
        str = [NSString stringWithFormat:@"%@ %@",lstr,rstr];
        
        NSLog(@"diqu%@",str);
        

    }
}
//点击确认按钮 将选中的区赋值
-(void)OKbtnCkick:(UIButton *)okBtn
{
    NSLog(@"queren确认安妮");
    
     NSLog(@"diqu%@",str);
    
    choessTF.text = [NSString stringWithFormat:@"%@",str];
    
    
    
}
//最后添加按钮的操作或者修改的按钮操作
-(void)okBtnClick
{
    NSLog(@"确认按钮点击");
    
    NSString *name = [ZJStaticFunction trimSpaceInTextField:nameTF.text];
    
    NSString *tel = [ZJStaticFunction trimSpaceInTextField:telTF.text];
    
    NSString *quYu = [ZJStaticFunction trimSpaceInTextField:choessTF.text];
    
    NSString *address = [ZJStaticFunction trimSpaceInTextField:addressTF.text];
    
    
    if (name.length==0)
    {
         [ZJStaticFunction alertView:self.view msg:@"请输入收货人姓名"];
        
          return;
        
    }
    if (tel.length==0)
    {
        [ZJStaticFunction alertView:self.view msg:@"请输入手机号码"];
        
        return;
        
    }
    if (![ZJStaticFunction isMobileNumber:tel])
    {
        [ZJStaticFunction alertView:self.view msg:@"手机号格式不正确"];
        
        return;
        
    }
    
    if (quYu.length==0)
    {
        
        [ZJStaticFunction alertView:self.view msg:@"请选择区域"];
        
        return;
        
    }
    
    if (address.length==0)
    {
        [ZJStaticFunction alertView:self.view msg:@"请填写详细地址"];
        
        return;
    }
    
    
    if (swch.on==YES)
    {
        NSLog(@"开关开着");
        
        OnisDefault = [NSString stringWithFormat:@"1"];
        
        
        
    }
    else
    {
        NSLog(@"开关关着");
        
        OnisDefault = [NSString stringWithFormat:@"0"];
        
        
    }

    
    
    if (_ressModel.Id == nil)
    {
        //确定添加收货请求
        
         [self loadDataAddressFormSever:kAddressOkUrl params:@{@"uid":Id,@"receive_name":nameTF.text,@"mobile":telTF.text,@"province_id":@"9",@"city_id":@"72",@"district_id":model.district_id,@"address":addressTF.text,@"is_default":OnisDefault}];
        
    }
    else
    {
        
        //编辑收货请求
        
          NSLog(@"districe_id%@",_ressModel.district_id);
        
        if (chooseAddress.AddPickVIew)
        {
            [self loadDataAddressFormSever:kAddressOkUrl params:@{@"uid":Id,@"id":_ressModel.Id,@"receive_name":nameTF.text,@"mobile":telTF.text,@"province_id":_ressModel.province_id,@"city_id":_ressModel.city_id,@"district_id":model.district_id,@"address":addressTF.text,@"is_default":OnisDefault}];

        }
        else
        {
            
            NSLog(@"没有pickVIiew");
            
            NSLog(@"districe_id%@",_ressModel.district_id);
            
           [self loadDataAddressFormSever:kAddressOkUrl params:@{@"uid":Id,@"id":_ressModel.Id,@"receive_name":nameTF.text,@"mobile":telTF.text,@"province_id":_ressModel.province_id,@"city_id":_ressModel.city_id,@"district_id":_ressModel.district_id,@"address":addressTF.text,@"is_default":OnisDefault}];
            
        }

        

        
        
    }
    
   

    
    
    
}
-(void)loadDataAddressFormSever:(NSString *)url params:(NSDictionary *)param
{
//    [self.HUD show:YES];
    
    //第一个待付款按钮触发的列表请求数据
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:self response:^(id json)
     {
         
         NSLog(@"我的点击最后添加按钮的数据%@",json);
         
        [ZJStaticFunction alertView:self.navigationController.view msg:@"操作成功"];
         
         if (self.detailCallBack)
         {
              self.detailCallBack(@"添加成功之后刷新地址的主界面");
             
         }
         
         [self.navigationController popViewControllerAnimated:YES];
         

         
     } error400Code:^(id failure)
     {
         
     }];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
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
