//
//  UIColor+HexString.h
//  BusinessManage
//
//  Created by Jion on 15/8/7.
//  Copyright (c) 2015年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
/**
 返回随机颜色
 */
+ (instancetype)randColor;

/**
 *  将16进制字符串转换成UIColor 可设置alpha值
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  将16进制字符串转换成UIColor
 */
+ (UIColor *) colorHexString: (NSString *) hexString;
@end
