//
//  ProductDetailController.h
//  BuldingMall
//
//  Created by Jion on 16/9/9.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BuyBottomView.h"

@protocol htmlXY <NSObject,JSExport>
@required

- (void)showIndex:(NSInteger )num;

@end


@interface ProductDetailController : BaseViewController<htmlXY>

@property(nonatomic,strong)BuyBottomView *toolBar;
@property(nonatomic,strong)NSString  *webPath;
@property(nonatomic,strong)NSString  *webRequestURL;
@property(nonatomic,strong)NSString  *params;

@end
