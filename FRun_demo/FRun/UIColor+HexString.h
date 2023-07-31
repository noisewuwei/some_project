//
//  UIColor+HexString.h
//  BusinessManage
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
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
