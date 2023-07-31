//
//  ThirdLoginView.m
//  BuldingMall
//
//  Created by Jion on 2016/10/24.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ThirdLoginView.h"

@implementation ThirdLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    CGFloat length = 100;
    
    CGFloat lineLong = (zScreenWidth-length - 20)/2.0 - 20;
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, lineLong, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"#808080"];
    [self addSubview:line1];
    
    UILabel *thirdTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+10, 0, length, 20)];
    thirdTitle.textAlignment = NSTextAlignmentCenter;
    thirdTitle.font = [UIFont systemFontOfSize:14];
    thirdTitle.textColor = [UIColor colorHexString:@"#808080"];
    
    thirdTitle.text = @"第三方账号登录";
    [self addSubview:thirdTitle];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(thirdTitle.frame)+10, 10, lineLong, 1)];
    line2.backgroundColor = [UIColor colorHexString:@"#808080"];
    [self addSubview:line2];
    
    UIImageView *sina = [self creatImageView:@"btn_qqdl" tag:LoginTypeSina];
    UIImageView *qq = [self creatImageView:@"btn_qqdl" tag:LoginTypeQQ];
    UIImageView *wechat = [self creatImageView:@"btn_wxdl" tag:LoginTypeWechat];
    
    [self addSubview:sina];
    [self addSubview:qq];
    [self addSubview:wechat];
    
    CGFloat Size = 70;
    CGFloat offset = (zScreenWidth - 2*Size)/3.0;
    CGFloat offY = 20 + CGRectGetMaxY(thirdTitle.frame);
    
    wechat.frame = CGRectMake(offset, offY, Size, Size);
    qq.frame = CGRectMake(CGRectGetMaxX(wechat.frame)+offset, offY, Size, Size);
    
}

- (UIImageView *)creatImageView:(NSString *)imageName tag:(NSUInteger)tag
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}
- (void)click:(UITapGestureRecognizer *)tapRec
{
    if (self.clickLogin) {
        self.clickLogin(tapRec.view.tag);
    }
}


@end
