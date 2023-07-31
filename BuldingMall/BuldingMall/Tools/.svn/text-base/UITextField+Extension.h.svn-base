//
//  UITextField+Extension.h
//  ConstructionCaptain
//
//  Created by Jion on 16/9/6.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CallBack)(BOOL complete);
@interface UITextField (Extension)
@property(nonatomic,copy,readonly)CallBack callBack;

@property(nonatomic,copy)NSString  *title;

@property(nonatomic,assign)BOOL  shouldInputAccessoryView;

-(void)showInputAccessoryView;

//获取按钮点击事件，返回complete为NO取消，YES完成
-(void)addTarget:(id)target action:(CallBack)sender;

@end
