//
//  ProductListController.m
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "ProductListController.h"
#import "ProductDetailController.h"
#import "CustomerServiceVC.h"

@interface ProductListController ()<UIWebViewDelegate>

@end

@implementation ProductListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"商品列表";
    
//    self.webRequestURL = [self.webRequestURL stringByAppendingString:@"?platform=app"];
    
    self.webView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight);
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.Hud show:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webRequestURL]]];
    
}
#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *path = request.URL.path;
    NSString * requestStr =[request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *body  =[[ NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    //一元夺宝，一元换购
    if ([path isEqualToString:@"/snatch/snatch_item"]||[path isEqualToString:@"/redemption/detail"] ||[path isEqualToString:@"/onsale/old_item"]) {
        ProductDetailController *productDetail = [[ProductDetailController alloc] init];
        productDetail.webPath = path;
        productDetail.webRequestURL=requestStr;
        [self.navigationController pushViewController:productDetail animated:YES];
        return NO;
    }else if ([path isEqualToString:@"/onsale/fuwu"]){
        CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
        customerService.webPath = path;
        customerService.webRequestURL = requestStr;
        
        [self.navigationController pushViewController:customerService animated:YES];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.Hud hide:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    if (title) {
//        self.title = title;
//    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.Hud hide:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
