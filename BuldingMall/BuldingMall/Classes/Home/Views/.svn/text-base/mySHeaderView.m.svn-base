//
//  mySHeaderView.m
//  colltest
//
//  Created by noise on 2016/10/13.
//  Copyright © 2016年 noise. All rights reserved.
//

#import "mySHeaderView.h"

@implementation mySHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    UIView *SectionheaderView = [[UIView alloc]init];
    
    SectionheaderView.frame = CGRectMake(0, 0, self.bounds.size.width, 235);
    
    SectionheaderView.backgroundColor=[UIColor colorHexString:@"f0f0f0"];//f0f0f0
    
    //创建头部的view
    UIView *topview  = [[UIView alloc] init];
    topview.frame = CGRectMake(0, 0, self.bounds.size.width, 35);
    topview.backgroundColor = [UIColor whiteColor];
    //创建头部的view背景图片
    UIImageView *hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-68, 7,17, 17)];
    hotImg.image = [UIImage imageNamed:@"btn_xxjc.png"];
    [topview addSubview:hotImg];
    //创建头部的view的uilable
    UILabel *hotlab = [[UILabel alloc]initWithFrame:CGRectMake(hotImg.frame.origin.x+22, 1, 200, 30)];
    hotlab.text = @"线下建材特卖会";
    hotlab.textColor = [UIColor colorHexString:@"dc0200"];//dc0200
    hotlab.font = [UIFont systemFontOfSize:17.0];
    [topview addSubview:hotlab];
    
    [SectionheaderView addSubview:topview];
    //创建免单背景图片的view
    UIView *picview = [[UIView alloc]init];
    picview.frame = CGRectMake(0, topview.frame.size.height, self.bounds.size.width, 150);
    _bgImg = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150)];
    
    [picview addSubview:_bgImg];
    [SectionheaderView addSubview:picview];
    
    //创建爆款预告的外面包含的大view
    UIView *bottomview = [[UIView alloc]init];
    bottomview.frame = CGRectMake(0, picview.frame.size.height+35, self.bounds.size.width, 50);
    bottomview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];//f0f0f0
    
    //创建爆款预告的view
    UIView *baoview = [[UIView alloc]init];
    baoview.frame = CGRectMake(0, 10,self.bounds.size.width, 35);
    baoview.backgroundColor = [UIColor whiteColor];
    
    UILabel *xianllab = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-60, 17, 15, 1)];
    xianllab.backgroundColor = [UIColor colorHexString:@"f0f0f0"];//f0f0f0
    [baoview addSubview:xianllab];
    
    UILabel *djfd = [[UILabel alloc]initWithFrame:CGRectMake(xianllab.frame.origin.x+23, 3, 100, 30)];
    djfd.text = @"爆款预告";
    djfd.font = [UIFont systemFontOfSize:17.0];
    [baoview addSubview:djfd];
    
    
    UILabel *xianllab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2+40, 17, 15, 1)];
    xianllab2.backgroundColor = [UIColor colorHexString:@"f0f0f0"];//f0f0f0
    [baoview addSubview:xianllab2];
    
    
    [bottomview addSubview:baoview];
    
    [SectionheaderView addSubview:bottomview];
    [self addSubview:SectionheaderView];
}
@end
