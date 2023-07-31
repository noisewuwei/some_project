//
//  TipWebViewController.m
//  BuldingMall
//
//  Created by noise on 16/9/26.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "TipWebViewController.h"

@interface TipWebViewController ()

@end

@implementation TipWebViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"温馨提醒";
    
//    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64)];
//    
//    textview.delegate = self;
//    
//    textview.backgroundColor = [UIColor whiteColor];
//    
//    textview.textColor = [UIColor blackColor];
//    
//    textview.font = [UIFont boldSystemFontOfSize:15];
//    
//    textview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    
//    textview.editable = NO;
//    
//    textview.scrollEnabled = YES;
//    
//    NSString *str = @"如果你看到这段文字，证明我们真的很有缘份。看你骨骼精奇，老衲将平生所学，皆倾传给你，如何？";
//    
//    textview.text = str;
//    
//    [self.view addSubview:textview];
    
    self.webView.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight-64);
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
    
    [self.view addSubview:self.webView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
