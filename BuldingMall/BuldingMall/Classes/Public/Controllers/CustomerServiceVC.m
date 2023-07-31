//
//  CustomerServiceVC.m
//  BuldingMall
//
//  Created by Jion on 16/9/12.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "CustomerServiceVC.h"

@interface CustomerServiceVC ()<UIWebViewDelegate>

@end

@implementation CustomerServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.webPath isEqualToString:@"/im/gateway"]||[self.webPath isEqualToString:@"/cps/chat"]) {
        self.title = @"客服中心";
        if (!self.webRequestURL) {
            self.webRequestURL = @"http://m.youjuke.com/index/kf_html";
        }
        
    }else if([self.webPath isEqualToString:@"/onsale/fuwu"]){
        
        if ([self.webRequestURL rangeOfString:@"?"].location != NSNotFound) {
            self.webRequestURL = [self.webRequestURL stringByAppendingString:@"&platform=app"];
        }else{
            self.webRequestURL = [self.webRequestURL stringByAppendingString:@"?platform=app"];
        }
        self.title = @"服务保障";
    }
    
    // Do any additional setup after loading the view.
    NSString *loadUrl = [self.webRequestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self buildWebView:loadUrl];
}
-(void)buildWebView:(NSString*)requestUrl{
    self.webView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight - zNavigationHeight);
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]]];
    [self.view addSubview:self.webView];
    [self.Hud show:YES];
    
}
#pragma mark --UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.Hud hide:YES];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.Hud hide:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
