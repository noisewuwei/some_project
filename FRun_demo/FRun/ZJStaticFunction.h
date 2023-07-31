//
//  ZJStaticFunction.h
//  BusinessManage
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJAlertView.h"
//#import "JSONKit.h"
#define remindErrMessage    @"加载失败"
#define remindNetWord   @"亲,请检查网络"

@interface ZJStaticFunction : NSObject
+(void)alertView:(UIView *)view msg:(NSString *)msg;
+(void)alertView:(UIView *)view msg:(NSString *)msg  leng:(int )le;
+(void)addAlertView:(UIView *)view msg:(NSString *)mag;
+(void)removeAlertView:(UIView *)view;

//文本设置行间距
+(NSAttributedString*)textSetLineSpace:(NSString*)text;
//根据文本计算有行间距的高度
+(CGFloat)textHeight:(NSString*)text font:(UIFont*)font showWidth:(CGFloat)showWidth;
//把get请求的URL的参数转化成字典
+(NSDictionary*)jsonGetUrlParam:(NSString*)urlStr;

//字符串转数组
+(NSArray *)getArrayByJsonString:(NSString *)str;
/*
 数组转字符
 */
+(NSString *)getJsonStringByArray:(NSArray *)array encoding:(NSStringEncoding)encoding;

//字符串转字典
+(NSDictionary *)getDictionaryByJsonString:(NSString *)str;
//字典转字符串
+(NSString *)getJsonStringByDictionary:(NSDictionary *)dictionary encoding:(NSStringEncoding)encoding;
/*
 判断一个字符串是否包含另一个字符串
 */
+(BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString;
/*
 去除空字符
 */
+(NSString *)trimSpaceInTextField:(NSString *)str;
/*
 判断请求状态是否成功
 */
+(BOOL)isCurrectResult:(NSDictionary *)dic;

/*
 请求数据转换
 */
//+(NSDictionary *)JsonData:(MKNetworkOperation *)request;

//版本字符串转换成整型
+(int)versionToInt:(NSString*)str;


/*
 判断网络
 */
//+(BOOL)isUserNetOK;
/*
 判断手机号
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;
/*
 验证是否是邮件
 */
+(BOOL)isValidateEmail:(NSString *)email;
/*
 开启打电话功能
 */
+(UIView*)callTelephone :(NSString *)phone;

//将图片处理成圆的
+(UIImage *)changeimagetocilce:(UIImage*)image;

/**
 *	@brief	判断对象是否为空、NULL、nil
 *
 *	@param 	obj 	对象
 *
 *	@return	返回BOOL值
 */
+(BOOL)isBlank:(id)obj;
+(NSString *)ShowErrorMessage:(NSString *)str;
+(void)copyWeixin;
+(void)copyWeibo;
@end
