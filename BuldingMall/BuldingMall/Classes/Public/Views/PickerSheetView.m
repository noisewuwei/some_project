//
//  PickerSheetView.m
//  BuldingMall
//
//  Created by Jion on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "PickerSheetView.h"

@interface PickerSheetView()
{
    GoodsClassificationsModel *classGoodsModel;
}
@property(nonatomic,weak)UIViewController    *viewController;
@property (nonatomic, strong) UIControl *controlForDismiss;
@property(nonatomic, strong)UIButton *dismissBtn;
@property(nonatomic, strong)UIImageView *image;
@property(nonatomic, strong)UILabel  *price;
//库存数量
@property(nonatomic, strong)UILabel  *surplus;
//补贴
@property(nonatomic, strong)UILabel *subsidyLabel;
@property(nonatomic,strong)UIView   *line1;
@property(nonatomic,strong)UIView   *line2;

//商品分类
@property(nonatomic, strong)UILabel  *shopClass;
@property(nonatomic, strong)UIView   *btnsView;
@property(nonatomic, strong)UIButton *tempBtn;

@property(nonatomic, strong)UILabel  *buyNumLabel;
@property(nonatomic, strong)UIView   *numberView;
@property(nonatomic, strong)UIButton *commitBtn;
//购买数量
@property(nonatomic, strong)UITextField *numberField;

//预付定金文本
@property(nonatomic, strong)UILabel * frontMoney;

@end

@implementation PickerSheetView
+(PickerSheetView *)instancePickerSheetView:(id)delegate commitBlock:(CommitBlock)commitBlock{
    
    PickerSheetView *sheet =[PickerSheetView instancePickerSheetView:delegate];
    sheet.commitBlock = commitBlock;
    
    return sheet;
}
+(PickerSheetView *)instancePickerSheetView:(id)delegate{
    PickerSheetView *sheetView = [[PickerSheetView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 300)];
    sheetView.viewController = delegate;
    [sheetView showInBlur:YES];
    return sheetView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(void)buildView{
    
    [self addSubview:self.dismissBtn];
    
    [self addSubview:self.image];
    
    [self addSubview:self.price];
    
    [self addSubview:self.surplus];
    
    [self addSubview:self.subsidyLabel];
    
    self.line1 = [self getLine:CGRectGetMaxY(self.image.frame)+5];
    [self addSubview:self.line1];
    
    [self addSubview:self.shopClass];
    
    [self addSubview:self.btnsView];
    
    self.line2 = [self getLine:CGRectGetMaxY(self.btnsView.frame)+10];
    [self addSubview:self.line2];
    
    [self addSubview:self.buyNumLabel];
    
    [self addSubview:self.numberView];
    
    [self addSubview:self.commitBtn];
    
}
- (NSAttributedString*)attributedChangeString:(NSString*)string range:(NSRange)range{
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return attributed;
}
#pragma mark -- setter
-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    //调用一次点击事件
    [self selectedGoodsClass:_tempBtn];
}

-(void)classificationBtns:(NSArray<GoodsClassificationsModel *>*)subClasses{
    
    CGFloat lastX = 0;
    CGFloat lastY = 0;
    
    CGFloat btnW = 0;
    CGFloat btnH = 30;
    CGFloat addW = 30;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    
    for (NSInteger k = 0; k < subClasses.count; k++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = k;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [[UIColor colorHexString:@"cccccc"] CGColor];
        if (k == 0) {
            _tempBtn = btn;
            _tempBtn.selected = YES;
            _tempBtn.layer.borderColor = [[UIColor colorHexString:@"#ff0033"] CGColor];
        }
        
        [btn setTitle:subClasses[k].name forState:UIControlStateNormal];
        [btn.titleLabel sizeToFit];
        [btn addTarget:self action:@selector(selectedGoodsClass:) forControlEvents:UIControlEventTouchUpInside];
        
        btnW = btn.titleLabel.frame.size.width + addW;
        
        if (self.btnsView.frame.size.width - lastX > btnW) {
            btn.frame = CGRectMake(lastX, lastY, btnW, btnH);
        }else{
            btn.frame = CGRectMake(0, lastY + marginY + btnH, btnW, btnH);
        }
        
        [self.btnsView addSubview:btn];
        
        lastX = CGRectGetMaxX(btn.frame) + marginX;
        lastY = btn.frame.origin.y;
        
        self.btnsView.frame = CGRectMake(10, CGRectGetMaxY(self.shopClass.frame)+10, self.frame.size.width-20, CGRectGetMaxY(btn.frame));
    }
    
    CGFloat tempY;
    
    if (_sheetType == SheetTypeMerit || _sheetType == SheetTypePrepare||_sheetType == SheetTypePayment1) {
        self.line2.hidden = YES;
        self.buyNumLabel.hidden = YES;
        self.numberView.hidden = YES;
        tempY = CGRectGetMaxY(self.btnsView.frame);
        
    }else if (_sheetType == SheetTypeSnatch1){
        self.line2.hidden = YES;
        self.shopClass.hidden = YES;
        self.btnsView.hidden = YES;
        self.buyNumLabel.frame = CGRectMake(10, CGRectGetMaxY(self.line1.frame)+10, 80, 30);
        self.numberView.frame = CGRectMake(CGRectGetMaxX(self.buyNumLabel.frame)+10, CGRectGetMaxY(self.line1.frame)+10, 180, 30);
        tempY = CGRectGetMaxY(self.numberView.frame);
    }
    else{
        self.line2.frame = CGRectMake(0, CGRectGetMaxY(self.btnsView.frame)+10, self.frame.size.width, 1);
        
        self.buyNumLabel.frame = CGRectMake(10, CGRectGetMaxY(self.line2.frame)+10, 80, 30);
        self.numberView.frame = CGRectMake(CGRectGetMaxX(self.buyNumLabel.frame)+10, CGRectGetMaxY(self.line2.frame)+10, 180, 30);
        tempY = CGRectGetMaxY(self.numberView.frame);
    }
    
    
     _commitBtn.frame = CGRectMake(0, tempY+30, self.frame.size.width, 45);
    
    self.frame = CGRectMake(0, zScreenHeight - CGRectGetMaxY(self.commitBtn.frame) , self.frame.size.width, CGRectGetMaxY(self.commitBtn.frame));
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
        if (count <= [classGoodsModel.num integerValue]) {
            _numberField.text = [NSString stringWithFormat:@"%ld",count];
        }else{
            [ZJStaticFunction alertView:self msg:@"库存不足啦!"];
        }
        
    }
}

-(void)selectedGoodsClass:(UIButton*)sender{
    if (_tempBtn) {
        _tempBtn.selected = NO;
        _tempBtn.layer.borderColor = [[UIColor colorHexString:@"#cccccc"] CGColor];
    }
    _tempBtn = sender;
    _tempBtn.selected = YES;
    _tempBtn.layer.borderColor = [[UIColor colorHexString:@"#ff0033"] CGColor];
    
    
    NSURL *imageUrl = [NSURL URLWithString:YouJuKeImageUrl(_goodsModel.goods_image)];
    [self.image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
    
    switch (_sheetType) {
        case SheetTypeDefault:
            case SheetTypeMerit:
            case SheetTypePayment1:
        {
            if (_goodsModel.classifications.count>0) {
                if (_tempBtn) {
                    classGoodsModel = _goodsModel.classifications[_tempBtn.tag];
                }else{
                    classGoodsModel = _goodsModel.classifications[0];
                }
                
                self.price.text = [NSString stringWithFormat:@"￥%@",classGoodsModel.seckill_price];
                [self.price sizeToFit];
                
                if ([classGoodsModel.num integerValue] > 0) {
                    NSString *text = [NSString stringWithFormat:@"剩余%@件",classGoodsModel.num];
                    self.surplus.attributedText = [self attributedChangeString:text range:NSMakeRange(2, text.length-3)];
                }else{
                    self.surplus.text = @"库存不足";
                }
                //补贴
                NSString *string = [NSString stringWithFormat:@"优居客已补贴￥%@",classGoodsModel.subsidy];
                self.subsidyLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(6, string.length-6)];
                //隐藏优居客已补贴
                self.subsidyLabel.hidden = YES;
                self.surplus.frame = CGRectMake(CGRectGetMaxX(self.price.frame)+10, CGRectGetMidY(self.price.frame)-5, 80, 10);
                [self.surplus sizeToFit];
                
                if (!classGoodsModel.num || classGoodsModel.num.length < 1 || [classGoodsModel.num integerValue] < 1) {
                    
                    _numberField.text = @"0";
                }else{
                    _numberField.text = @"1"; 
                }
            }

        }
            break;
        case SheetTypePrepare:
        {
            if (_goodsModel.classifications.count>0) {
                if (_tempBtn) {
                    classGoodsModel = _goodsModel.classifications[_tempBtn.tag];
                }else{
                    classGoodsModel = _goodsModel.classifications[0];
                }
                
                self.price.text = @"￥10";
                [self.price sizeToFit];
                
                self.frontMoney.text = @"预付定金";
                [self addSubview:self.frontMoney];
                
                //总价
                NSString *string = [NSString stringWithFormat:@"商品总价￥%@",classGoodsModel.seckill_price];
                self.subsidyLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(4, string.length-4)];
                [self.subsidyLabel sizeToFit];
                
                self.surplus.frame = CGRectMake(CGRectGetMaxX(self.subsidyLabel.frame)+10, CGRectGetMinY(self.subsidyLabel.frame), 80, 10);
                
                if ([classGoodsModel.num integerValue] > 0) {
                    NSString *text = [NSString stringWithFormat:@"剩余%@件",classGoodsModel.num];
                    self.surplus.attributedText = [self attributedChangeString:text range:NSMakeRange(2, text.length-3)];
                }else{
                    self.surplus.text = @"库存不足";
                }
                [self.surplus sizeToFit];
                
                if (!classGoodsModel.num || classGoodsModel.num.length < 1 || [classGoodsModel.num integerValue] < 1) {
                    
                    _numberField.text = @"0";
                }else{
                    _numberField.text = @"1"; 
                }
            }

        }
            break;
        case SheetTypeSnatch1:
        {
            self.price.text = [NSString stringWithFormat:@"￥%@",classGoodsModel.seckill_price?classGoodsModel.seckill_price:@"1"];
            [self.price sizeToFit];
            if ([classGoodsModel.num integerValue] > 0) {
                NSString *text = [NSString stringWithFormat:@"参与%@人次",classGoodsModel.num];
                self.surplus.attributedText = [self attributedChangeString:text range:NSMakeRange(2, text.length-3)];
            }else{
                self.surplus.text = @"夺宝人次已满";
            }
            self.surplus.frame = CGRectMake(CGRectGetMaxX(self.price.frame)+10, CGRectGetMidY(self.price.frame)-5, 80, 10);
            [self.surplus sizeToFit];
            
             self.subsidyLabel.text = @"一元夺宝 共需200人次";
            
        }
            break;
        
            
        default:
            break;
    }
    
    if (_btnsView.subviews.count<=0) {
        [self classificationBtns:_goodsModel.classifications];
    }
    
    
}

-(void)actionDismissClick:(UIButton*)sender{
    [self animatedOut];
}

-(void)commitActionClick:(UIButton*)sender{
    //有分类时必须选择分类，或者没有选择分类选项如（一元夺宝）返回YES.
    BOOL isSelectOrSnatch = (_tempBtn && _tempBtn.selected)|| _sheetType == SheetTypeSnatch1;
    
    if (isSelectOrSnatch) {
        
        if ([classGoodsModel.num integerValue]<1) {
            if (_sheetType == SheetTypeSnatch1) {
                [ZJStaticFunction alertView:self msg:@"夺宝人次已满!"];
            }else{
                [ZJStaticFunction alertView:self msg:@"库存不足啦!"];
            }
            
            return;
        }
        
        if (_sheetType == SheetTypeSnatch1) {
            classGoodsModel.buyNumber = _numberField.text;
            if (self.commitBlock) {
                self.commitBlock(_goodsModel);
            }
            return;
        }
        
        // 0-普通订单, 1-10元预购购买, 2-10元预购使用, 3-当期秒杀, 4-当期秒杀并使用10元预购, 5-10元预抢, 6-10元预抢生成的订单, 7-往期秒杀, 8-触摸屏，9-商家触摸屏，10-自营触摸屏,11-一元换购,12-扫码支付,13-建材馆录入订单
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
        // 用户id
        if (user_id && user_id.length > 0) {
            [dict setObject:user_id forKey:@"user_id"];
        }
        // 订单类型 默认为0
        //目前只有10元预抢时 传type = 5 其他情况不传
        if (_sheetType == SheetTypePrepare) {
            [dict setObject:[NSNumber numberWithInteger:self.sheetType] forKey:@"type"];
        }
        
        //1元换购时需要 传一个字段redemption_id
        if (_sheetType == SheetTypePayment1) {
            [dict setObject:_goodsModel.redemption_id forKey:@"redemption_id"];
        }
        
        // 商品分类 值是@{classification：分类商品的id}
        NSMutableDictionary *classifiDict = [NSMutableDictionary dictionary];
        if (classGoodsModel.classifications_id) {
            [classifiDict setObject:classGoodsModel.classifications_id forKey:@"classification"];
        }
        [classifiDict setObject:classGoodsModel.name forKey:@"name"];
        
        // 商品分类对应的数量 没有该参数表示秒杀
        if (self.numberView.hidden == NO) {
            [classifiDict setObject:_numberField.text forKey:@"num"];
        }
        
        [dict setObject:@[classifiDict] forKey:@"goods_info"];
        
//        // 换购活动id
//        [dict setObject:@"1" forKey:@"redemption_id"];
//        // 订单类型
//        [dict setObject:@"0" forKey:@"onsale_type"];
//        // 渠道来源
//        [dict setObject:@"putin_qd" forKey:@"putin_qd"];
//        // 创意来源
//        [dict setObject:@"putin_cy" forKey:@"putin_cy"];
        
        if (user_id && user_id.length > 0) {
            if (self.commitBlock) {
                self.commitBlock(dict);
            }
        }else{
             [LonginController isLongin:self.viewController completion:^{
                NSString *user_id = [[ZJStoreDefaults getObjectForKey:LoginSucess] objectForKey:@"id"];
                [dict setObject:user_id forKey:@"user_id"];
                if (self.commitBlock) {
                    self.commitBlock(dict);
                }
            }];
        }
        
        [self animatedOut];
        
    }else{
        [ZJStaticFunction alertView:self msg:@"请选择商品分类"];
    }
    
}


#pragma mark -- getter
-(UIView*)getLine:(CGFloat)y{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    return line;
}

-(UIView*)numberView{
    if (!_numberView) {
        _numberView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buyNumLabel.frame)+10, CGRectGetMaxY(self.line2.frame)+20, 180, 30)];
        _numberView.layer.borderColor = [[UIColor colorHexString:@"#959595"] CGColor];
        _numberView.layer.borderWidth = 1.0;
        
        UIView *verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(_numberView.frame.size.width/3, 0, 1, _numberView.frame.size.height)];
        verticalLine1.backgroundColor = [UIColor colorHexString:@"#959595"];
        [_numberView addSubview:verticalLine1];
        UIView *verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(_numberView.frame.size.width*2/3, 0, 1, _numberView.frame.size.height)];
        verticalLine2.backgroundColor = [UIColor colorHexString:@"#959595"];
        [_numberView addSubview:verticalLine2];
        
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reduceBtn.frame = CGRectMake(0, 0, _numberView.frame.size.width/3,  _numberView.frame.size.height);
        reduceBtn.tag = 111;
        reduceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [reduceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [reduceBtn addTarget:self action:@selector(changeBuyCount:) forControlEvents:UIControlEventTouchUpInside];
        [_numberView addSubview:reduceBtn];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(_numberView.frame.size.width*2/3, 0, _numberView.frame.size.width/3,  _numberView.frame.size.height);
        addBtn.tag = 222;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(changeBuyCount:) forControlEvents:UIControlEventTouchUpInside];
        [_numberView addSubview:addBtn];
        
        _numberField = [[UITextField alloc] initWithFrame:CGRectMake(_numberView.frame.size.width/3, 0, _numberView.frame.size.width/3,  _numberView.frame.size.height)];
        _numberField.tag = 333;
        _numberField.textAlignment = NSTextAlignmentCenter;
        _numberField.enabled = NO;
        _numberField.text = @"1";
        [_numberView addSubview:_numberField];
    }
    return _numberView;
}

-(UIButton*)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(self.frame.size.width-50, 10, 40, 40);
        [_dismissBtn setImage:[UIImage imageNamed:@"btn_del1"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(actionDismissClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

-(UIImageView*)image{
    if (!_image) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        _image.layer.borderColor = [[UIColor colorHexString:@"#d2d2d2"] CGColor];
        _image.layer.borderWidth = 1.0;
        _image.layer.cornerRadius = 3.0;
        _image.layer.masksToBounds = YES;
        _image.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return  _image;
}

-(UILabel*)price{
    if (!_price) {
        _price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame)+10, 10, 60, 30)];
        _price.textColor = [UIColor colorHexString:@"ff0033"];
        _price.font = [UIFont boldSystemFontOfSize:22];
        
        _price.text = @"￥0.00";
        [_price sizeToFit];
    }
    return _price;
}
-(UILabel*)surplus{
    if (!_surplus) {
        _surplus = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.price.frame)+10, CGRectGetMinY(self.price.frame), 80, 30)];
        _surplus.font = [UIFont systemFontOfSize:11];
        _surplus.textColor = [UIColor colorHexString:@"#999999"];
        NSString *text = @"剩余0件";
        _surplus.attributedText = [self attributedChangeString:text range:NSMakeRange(2, text.length-3)];
    }
    
    return _surplus;
}
-(UILabel*)frontMoney{
    if (!_frontMoney) {
        _frontMoney = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.price.frame)+10, CGRectGetMinY(self.price.frame)+5, 80, 30)];
        _frontMoney.font = [UIFont systemFontOfSize:11];
        _frontMoney.textColor = [UIColor colorHexString:@"#999999"];
        _frontMoney.text = @"预付定金";
        [_frontMoney sizeToFit];
    }
    
    return _frontMoney;
}
-(UILabel*)subsidyLabel{
    if (!_subsidyLabel) {
        _subsidyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.price.frame), CGRectGetMaxY(self.price.frame), 200, 20)];
        _subsidyLabel.font = [UIFont systemFontOfSize:11];
        NSString *string = @"优居客已补贴￥0.0";
        _subsidyLabel.attributedText = [self attributedChangeString:string range:NSMakeRange(6, string.length-6)];
    }
    
    return  _subsidyLabel;
}
-(UILabel*)shopClass{
    if (!_shopClass) {
        _shopClass = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.line1.frame)+10, 100, 30)];
        _shopClass.font = [UIFont systemFontOfSize:16];
        _shopClass.text = @"商品分类";
    }
    
    return _shopClass;
}

-(UIView*)btnsView{
    if (!_btnsView) {
        _btnsView = [[UIView alloc] init];
        _btnsView.frame = CGRectMake(10, CGRectGetMaxY(self.shopClass.frame)+10, self.frame.size.width-20, 30);
    }
    
    return _btnsView;
}
-(UILabel*)buyNumLabel{
    if (!_buyNumLabel) {
        _buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.line2.frame)+20, 80, 30)];
        _buyNumLabel.font = [UIFont systemFontOfSize:16];
        _buyNumLabel.text = @"购买数量";
    }
    
    return _buyNumLabel;
}
-(UIButton*)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(0, self.frame.size.height - 45, self.frame.size.width, 45);
        _commitBtn.backgroundColor = [UIColor colorHexString:@"#ff0033"];
        _commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitActionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _commitBtn;
}


#pragma mark -- 添加蒙版
-(void)showInBlur:(BOOL)blur
{
    if (nil == _controlForDismiss && blur)
    {
        _controlForDismiss = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIWindow *keywindow = [[UIApplication sharedApplication]keyWindow];
    if (_controlForDismiss)
    {
        [keywindow addSubview:_controlForDismiss];
    }
    
    self.frame = CGRectMake(0, zScreenHeight, zScreenWidth, self.bounds.size.height);
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, zScreenHeight-self.bounds.size.height, zScreenWidth, self.bounds.size.height);
    }];
    [keywindow addSubview:self];
    
}
#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)touchForDismissSelf:(id)sender
{
    [self animatedOut];
}
- (void)animatedOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.frame = CGRectMake(0, zScreenHeight, zScreenWidth, self.bounds.size.height);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (_controlForDismiss)
            {
                [_controlForDismiss removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];
}


@end
