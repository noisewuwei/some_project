//
//  UITextField+Extension.m
//  ConstructionCaptain
//
//  Created by Jion on 16/9/6.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

@implementation UITextField (Extension)
static const void *kShouldInputAccessoryView = @"shouldInputAccessoryView";
static const void *kCallBack = @"CallBack";
static const void *kTitle = @"ContentTitle";

#pragma mark --- getter setter
-(BOOL)shouldInputAccessoryView{
    
    return [objc_getAssociatedObject(self, kShouldInputAccessoryView) boolValue];
}
-(void)setShouldInputAccessoryView:(BOOL)shouldInputAccessoryView{
    if (shouldInputAccessoryView) {
        [self showInputAccessoryView];
    }
    
    objc_setAssociatedObject(self, kShouldInputAccessoryView, [NSNumber numberWithBool:shouldInputAccessoryView], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString*)title{
    return objc_getAssociatedObject(self, kTitle);
}

-(void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, kTitle, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CallBack)callBack{
    return objc_getAssociatedObject(self, kCallBack);
}
-(void)setCallBack:(CallBack)callBack{
    objc_setAssociatedObject(self, kCallBack, callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark ---Externd Method
-(void)addTarget:(id)target action:(CallBack)sender{
    self.callBack = sender;
}
-(void)showInputAccessoryView{
    self.inputAccessoryView = [self createInputAccessoryView:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
}

#pragma mark ---Private Method

-(UIView*)createInputAccessoryView:(CGRect)rect{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 40)];
    toolBar.barTintColor = [UIColor whiteColor];
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 1)];
    //    lineView.backgroundColor = [UIColor blackColor];
    //    lineView.alpha = 0.1;
    //    [toolBar addSubview:lineView];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, rect.size.width, toolBar.frame.size.height-1)];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor lightGrayColor];
    titleLable.alpha = 0.8;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = self.title?self.title:@"请输入内容";
    [toolBar addSubview:titleLable];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, 1, 60, toolBar.frame.size.height - 1);
    cancleButton.tag = 10;
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(loseFirstResponse:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:cancleButton];
    
    UIButton *determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.frame = CGRectMake(rect.size.width - 60, 1, 60, toolBar.frame.size.height - 1);
    determineButton.tag = 11;
    determineButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(loseFirstResponse:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:determineButton];
    
    return toolBar;
}
-(void)loseFirstResponse:(UIButton*)sender{
    
    [self resignFirstResponder];
    if (self.callBack) {
        if (sender.tag == 11) {
            self.callBack(YES);
        }else{
            self.callBack(NO);
        }
    }
    
    sender.superview.hidden = YES;
    [self performSelector:@selector(accessoryViewShowToolBar:) withObject:sender.superview afterDelay:0.5];
}
-(void)accessoryViewShowToolBar:(UIView*)toolBar{
    toolBar.hidden = NO;
}




@end
