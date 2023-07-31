//
//  myHeadView.m
//  colltest
//
//  Created by noise on 2016/10/13.
//  Copyright © 2016年 noise. All rights reserved.
//

#import "myHeadView.h"

@implementation myHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.backgroundColor = [UIColor colorHexString:@"f0f0f0"];//f0f0f0
    _scrollview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,150)];
    _scrollview.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 160, self.bounds.size.width, 73)];
    _view1.backgroundColor = [UIColor whiteColor];
    
    _imagefuwu = [[UIImageView alloc]initWithFrame:CGRectMake(20, 14, 51, 46)];
    _imagefuwu.contentMode = UIViewContentModeCenter;
    _imagefuwu.image = [UIImage imageNamed:@"btn_fwbb.png"];
    
    _labelbb = [[UILabel alloc]initWithFrame:CGRectMake(100, 14, self.bounds.size.width-115, 45)];
    _labelbb.numberOfLines = 0;
    _labelbb.textColor = [UIColor colorHexString:@"333333"];//333333
    _labelbb.font = [UIFont systemFontOfSize:16];
    _labelbb.text = @"       李先生订购的小米橱柜18:30已按时安装!";
    
    _viewc = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 25, 15)];
//    _viewc.backgroundColor = [UIColor colorHexString:@"dc0200"];//dc0200
    _viewc.layer.cornerRadius = 3;
    
    
    
    _labelc = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 15)];
    _labelc.textColor = [UIColor whiteColor];
    _labelc.font = [UIFont boldSystemFontOfSize:11];
    _labelc.textAlignment = NSTextAlignmentCenter;
    _labelc.text = @"红榜";
    
    [_viewc addSubview:_labelc];
    
    [_labelbb addSubview:_viewc];
    
    [_view1 addSubview:_labelbb];
    [_view1 addSubview:_imagefuwu];
    
    
    
    
    
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 160+73+1, self.bounds.size.width, 116)];
    _view2.backgroundColor = [UIColor whiteColor];
 
    _bkbtn = [[UIButton alloc]initWithFrame:CGRectMake(32, 20, 60, 60)];
    [_bkbtn setImage:[UIImage imageNamed:@"btn_ms.png"] forState:UIControlStateNormal];
    _jxbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-30, 20, 60, 60)];
    [_jxbtn setImage:[UIImage imageNamed:@"btn_rq.png"] forState:UIControlStateNormal];
    _xxbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-92, 20, 60, 60)];
    [_xxbtn setImage:[UIImage imageNamed:@"btn_xxtm.png"] forState:UIControlStateNormal];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20, -10, 65, 20)];
    image.image = [UIImage imageNamed:@"btn_title3"];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2.5, 63, 15)];
    _timeLabel.textColor = [UIColor colorHexString:@"ffffff"];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.text = @"10.12-10.16";
    
    [image addSubview:_timeLabel];
    
    [_xxbtn addSubview:image];
    
    UILabel *labelbk = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, 64, 20)];
    labelbk.font = [UIFont systemFontOfSize:14];
    labelbk.textAlignment = NSTextAlignmentCenter;
    labelbk.textColor = [UIColor colorHexString:@"656565"];//656565
    labelbk.text = @"爆款秒杀";
    
    UILabel *labeljx = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-32, 90, 64, 20)];
    labeljx.font = [UIFont systemFontOfSize:14];
    labeljx.textAlignment = NSTextAlignmentCenter;
    labeljx.textColor = [UIColor colorHexString:@"656565"];//656565
    labeljx.text = @"精选特卖";
    
    UILabel *labelxx = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-94, 90, 64, 20)];
    labelxx.font = [UIFont systemFontOfSize:14];
    labelxx.textAlignment = NSTextAlignmentCenter;
    labelxx.textColor = [UIColor colorHexString:@"656565"];//656565
    labelxx.text = @"线下特卖";
    
    
    [_view2 addSubview:labelbk];
    [_view2 addSubview:labeljx];
    [_view2 addSubview:labelxx];
    [_view2 addSubview:_bkbtn];
    [_view2 addSubview:_jxbtn];
    [_view2 addSubview:_xxbtn];
    
    
    _view3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 160+73+1+116+10, self.bounds.size.width, 80)];

    
    _view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 160+73+1+116+10+80+10, self.bounds.size.width, 223)];
    _view4.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelkb = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, self.bounds.size.width, 20)];
    labelkb.textAlignment = NSTextAlignmentCenter;
    labelkb.font = [UIFont boldSystemFontOfSize:20];
    labelkb.textColor = [UIColor colorHexString:@"dc0200"];//dc0200
    labelkb.text = @"今日亏本秒杀";
    
    UILabel *labelbj = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, self.bounds.size.width, 20)];
    labelbj.textAlignment = NSTextAlignmentCenter;
    labelbj.font = [UIFont systemFontOfSize:14];
    labelbj.textColor = [UIColor colorHexString:@"333333"];//333333
    labelbj.text = @"全网公开比价 买贵就赔";
    
    _imagems = [[UIButton alloc]initWithFrame:CGRectMake(15, 72, 140, 140)];
//    _imagems.backgroundColor = [UIColor yellowColor];
    
    _labelms = [[UILabel alloc]initWithFrame:CGRectMake(167, 62, self.bounds.size.width-167-15, 70)];
    _labelms.numberOfLines = 0;
    _labelms.textColor = [UIColor colorHexString:@"000000"];//000000
    _labelms.font = [UIFont systemFontOfSize:13];
 //   _labelms.text = @"方太JX25ES+FD23BE侧吸双电机触控抽油烟机燃气灶套餐 烟灶套装";
    
    _labelrmb = [[UILabel alloc]initWithFrame:CGRectMake(167, 144, 10, 10)];
    _labelrmb.textColor = [UIColor colorHexString:@"ff0033"];//ff0033
    _labelrmb.font = [UIFont systemFontOfSize:12];
    _labelrmb.text = @"¥";
    
    _money = [[UILabel alloc]initWithFrame:CGRectMake(177, 132, self.bounds.size.width-177-15, 25)];
    _money.textColor = [UIColor colorHexString:@"ff0033"];//ff0033
    _money.font = [UIFont systemFontOfSize:22];
    _money.text = @"4500.00";
    
    _tm = [[UILabel alloc]initWithFrame:CGRectMake(167, 160, (self.bounds.size.width-167-15)/2, 15)];
    _tm.textColor = [UIColor colorHexString:@"8d8d8d"];//8d8d8d;
    _tm.font = [UIFont systemFontOfSize:12];
//    _tm.text = @"天猫:¥6000";
    
    _jd = [[UILabel alloc]initWithFrame:CGRectMake(167+(self.bounds.size.width-167-15)/2, 160, (self.bounds.size.width-167-15)/2, 15)];
    _jd.textColor = [UIColor colorHexString:@"8d8d8d"];//8d8d8d;
    _jd.font = [UIFont systemFontOfSize:12];
//    _jd.text = @"京东:¥6000";
    
    _ljqgbtn = [[UIButton alloc]initWithFrame:CGRectMake(167, 185, self.bounds.size.width-167-15, 27)];
    [_ljqgbtn setBackgroundColor:[UIColor colorHexString:@"ff0033"]];//ff0033
    [_ljqgbtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    _ljqgbtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    
    
    [_view4 addSubview:labelkb];
    [_view4 addSubview:labelbj];
    [_view4 addSubview:_imagems];
    [_view4 addSubview:_labelms];
    [_view4 addSubview:_labelrmb];
    [_view4 addSubview:_money];
    [_view4 addSubview:_tm];
    [_view4 addSubview:_jd];
    [_view4 addSubview:_ljqgbtn];
    
    _view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 160+73+1+116+10+80+10+223+10, self.bounds.size.width, 35)];
    _view5.backgroundColor = [UIColor whiteColor];
    
    UIImageView *hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-60, 7,17, 17)];
    hotImg.image = [UIImage imageNamed:@"btn_hot.png"];
    [_view5 addSubview:hotImg];
    
    UILabel *hotlab = [[UILabel alloc]initWithFrame:CGRectMake(hotImg.frame.origin.x+22, 1, 200, 30)];
    hotlab.text = @"热销建材榜单";
    hotlab.textColor = [UIColor colorHexString:@"dc0200"];//dc0200
    hotlab.font = [UIFont systemFontOfSize:17.0];
    [_view5 addSubview:hotlab];
    
    
    
    [self addSubview:_scrollview];
    [self addSubview:_view1];
    [self addSubview:_view2];
    [self addSubview:_view3];
    [self addSubview:_view4];
    [self addSubview:_view5];
    
    
}



@end
