//
//  TypeItemView.m
//  BuldingMall
//
//  Created by zfy on 16/9/13.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "TypeItemView.h"
@interface TypeItemView()<UIScrollViewDelegate>
{
    UIScrollView *_smallScrollView;
    UIScrollView    *_bigScrollView;
    
    NSArray  *_array;
    NSMutableArray   *_itemArray;
    
    
    UIImageView         *_guideImage;
    CGRect              _frame;

    
}
@end

@implementation TypeItemView

-(instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        
        _frame = frame;
        
        _array = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];

        
        [self setUpp];
        
        
    }
    
    return self;
    
}




//初始化
-(void)setUpp
{
    
    _itemArray = [NSMutableArray array];
    _tableArray = [NSMutableArray array];
    
    _smallScrollView = [[UIScrollView alloc]init];
    _smallScrollView.bounces = NO;
    _smallScrollView.directionalLockEnabled = YES;
    _smallScrollView.showsVerticalScrollIndicator = NO;
    _smallScrollView.showsHorizontalScrollIndicator = NO;
    _smallScrollView.alwaysBounceVertical = NO;
    _smallScrollView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    _smallScrollView.layer.borderWidth = 1.0f;
    
    _guideImage = [[UIImageView alloc]init];
    _guideImage.backgroundColor = [UIColor colorHexString:@"#00c24f"];
    
    
    _bigScrollView = [[UIScrollView alloc]init];
    _bigScrollView.delegate = self;
    _bigScrollView.scrollEnabled = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.showsHorizontalScrollIndicator = YES;
    
    for (int j=0; j<_array.count; j++)
    {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 0.1f)];
        table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 0.1f)];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableArray addObject:table];
        
       
        TypeRemindButton *btn = [TypeRemindButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_itemArray addObject:btn];
        

    }
    
    [self loadsubViews];

    
}

-(NSMutableArray *)tableArray
{
    return _tableArray;
    
}

-(void)loadsubViews
{
    _smallScrollView.frame = CGRectMake(0, 0, _frame.size.width, 41);
    if (_array.count>5)
    {
        _smallScrollView.contentSize = CGSizeMake(_array.count*(_frame.size.width)/5.0, 41);
        
    }
    else
    {
        _smallScrollView.contentSize = CGSizeMake(_frame.size.width, 41);
        
    }
    
    _smallScrollView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_smallScrollView];
    
    [_smallScrollView addSubview:_guideImage];
    
    _scRect = CGRectMake(0, CGRectGetMaxY(_smallScrollView.frame), _frame.size.width, _frame.size.height-CGRectGetMaxY(_smallScrollView.frame));
    _bigScrollView.frame = _scRect;
//    _bigScrollView.backgroundColor = [UIColor colorHexString:@"#f0f0f0"];
    _bigScrollView.backgroundColor = [UIColor orangeColor];
    
    _bigScrollView.contentSize = CGSizeMake(_frame.size.width*_array.count, _scRect.size.height-CGRectGetMaxY(_smallScrollView.frame));
    
    [self addSubview:_bigScrollView];
    
    for (int j=0; j<_array.count; j++)
    {
        int coloum = j%_array.count;
        float Xoffset = 5;
        float h = 40;
        float w;
        
        w = (_frame.size.width)/5.0-Xoffset;
        
        float x = Xoffset+(w+Xoffset)*coloum;
        
        TypeRemindButton *btn = _itemArray[j];
        [btn custum:CGRectMake(x, 0, w, h)];
        
        btn.tag = j;
        [btn setTitle:_array[j] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor colorHexString:@"#4c4c4c"] forState:UIControlStateNormal];
        
        
        if (j == 0)
        {
            [btn setTitleColor:kGlobalColor forState:UIControlStateNormal];
            _guideImage.frame = CGRectMake(x+w/6, 38, w*2/3, 3);
            
        }
        
        
        [btn addTarget:self action:@selector(ItemTtitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_smallScrollView addSubview:btn];
        
        //表
        UITableView *table = _tableArray[j];
        table.tag = j;
        if (j==0)
        {
            table.frame = CGRectMake(coloum*_frame.size.width, 0, _frame.size.width, _bigScrollView.frame.size.height);
            
        }
        else
        {
            table.frame = CGRectMake(coloum*_frame.size.width, 0, _frame.size.width, _bigScrollView.frame.size.height);
            
        }
        
        [_bigScrollView addSubview:table];
        
        
        
    }
    
}

//-(void)setDelegate:(id<TypeItemViewDelegate>)delegate
//{
//    _delegate = delegate;
//    if ([_delegate respondsToSelector:@selector(itemView:didSelectItem:table:)]&&_itemArray.count>0)
//    {
//        [_delegate itemView:self didSelectItem:_itemArray[0] table:_tableArray[0]];
//        
//    }
//}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
   TypeRemindButton *remind = _itemArray[selectIndex];
    [self ItemTtitleAction:remind];
    
}

//点击上面5个选项触发的事件
-(void)ItemTtitleAction:(TypeRemindButton *)sender
{
    NSLog(@"====%ld",(long)sender.tag);
    for (UIView *view in _smallScrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *b = (UIButton *)view;
            [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
    }

    [sender setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _guideImage.frame = CGRectMake(sender.frame.origin.x+sender.frame.size.width/6, 38, sender.frame.size.width*2/3, 3);
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint chagePoint;
        CGFloat weight = sender.frame.size.width;
        if (sender.frame.origin.x >= _smallScrollView.contentSize.width/2)
        {
            
            chagePoint = CGPointMake(_smallScrollView.contentSize.width-5*(weight+5)+5, 0);
            
            
        }
        else
        {
            chagePoint = CGPointMake(0, 0);
            
        }
        
        
        _smallScrollView.contentOffset = chagePoint;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    CGPoint p = CGPointMake(sender.tag*_frame.size.width, 0);
    [_bigScrollView setContentOffset:p animated:YES];
    
    
    if ([self.delegate respondsToSelector:@selector(itemView:didSelectItem:table:)])
    {
        [self.delegate itemView:self didSelectItem:sender table:_tableArray[sender.tag]];
        
    }
    

}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
