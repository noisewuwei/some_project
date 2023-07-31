//
//  OnSaleController.m
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "OnSaleController.h"
#import "ProductDetailController.h"
#import "CustomerServiceVC.h"

@interface OnSaleController ()<UIWebViewDelegate>

@end

@implementation OnSaleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"线下特卖";
    
    [self buildWebView];
}
-(void)buildWebView{
    self.webView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight);
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.Hud show:YES];
    [self refreshWebView];
    self.webView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshWebView)];
    
}

-(void)refreshWebView{
    [self.webView.scrollView.header beginRefreshing];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kSaleWebUrl]]];
}


#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *path = request.URL.path;
    NSString * requestStr =[request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *body  =[[ NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    if ([path isEqualToString:@"/cps/chat"]||[path isEqualToString:@"/im/gateway"]) {
        CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
        customerService.webPath = path;
        [self.navigationController pushViewController:customerService animated:YES];
        return NO;
    }else if([path isEqualToString:@"/onsale/old_item"]){
        ProductDetailController *productDetail = [[ProductDetailController alloc] init];
        productDetail.webPath = path;
        productDetail.webRequestURL=requestStr;
        [self.navigationController pushViewController:productDetail animated:YES];
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.Hud hide:YES afterDelay:1.5];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.webView.scrollView.header endRefreshing];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.Hud hide:YES];
    [self.webView.scrollView.header endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
