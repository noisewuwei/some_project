//
//  ZLCGuidePageView.m
//  GuidePage_Test
//
//  Created by shining3d on 16/6/7.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import "ZLCGuidePageView.h"
#import "ZJTabBarController.h"



#define Button_Name    @"立即体验"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ZLCGuidePageView

- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images
{
	self = [super initWithFrame:frame];
	if (self) {
		//设置引导视图的scrollview
		self.guidePageView = [[UIScrollView alloc]initWithFrame:frame];
		self.guidePageView.backgroundColor = [UIColor whiteColor];
		self.guidePageView.contentSize = CGSizeMake(SCREEN_WIDTH*images.count, SCREEN_HEIGHT);
		self.guidePageView.bounces = NO;
		self.guidePageView.pagingEnabled = YES;
		self.guidePageView.showsHorizontalScrollIndicator = NO;
		self.guidePageView.delegate = self;
		[self addSubview:_guidePageView];
		
		//设置引导页上的跳过按钮
		UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.1, 50, 25)];
		[btn setTitle:@"跳过" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
		btn.backgroundColor = [UIColor colorHexString:@"#ebebeb"];
		btn.layer.cornerRadius = 5;
		[btn addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
		
		//添加在引导视图上的多张引导图片
		for (int i=0; i<images.count; i++) {
			UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
			imageView.image = images[i];
			[self.guidePageView addSubview:imageView];
        
			//设置在最后一张图片上显示进入体验按钮
			if (i == images.count-1) {
				imageView.userInteractionEnabled = YES;
				UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT*0.8, 180, 47)];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 5;
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = [UIColor colorHexString:@"#0ac456"].CGColor;
                
				[btn setTitle:Button_Name forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
				[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor colorHexString:@"#0ac456"];
				[btn addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
				[imageView addSubview:btn];
			}
			
		}
		
		//设置引导页上的页面控制器
//		self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.08, SCREEN_HEIGHT*0.9, SCREEN_WIDTH*0.9, 50)];
        self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT*0.9, 100, 50)];
		self.imagePageControl.currentPage = 0;
		self.imagePageControl.numberOfPages = images.count;

        self.imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.imagePageControl.currentPageIndicatorTintColor = [UIColor colorHexString:@"#0ac456"];
        
		[self addSubview:self.imagePageControl];
		
	}
	return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
	int page = scrollview.contentOffset.x / scrollview.frame.size.width;
	[self.imagePageControl setCurrentPage:page];
}

- (void)btn_Click:(UIButton *)sender
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
	[UIView animateWithDuration:0.5 animations:^{
		self.alpha = 0;
	}];
	[self performSelector:@selector(removeGuidePage) withObject:nil afterDelay:1];

}

- (void)removeGuidePage
{
	[self removeFromSuperview];
	
}

@end
