//
//  ZJStaticFunction.m
//  BusinessManage
//
//  Created by Jion on 15/8/7.
//  Copyright (c) 2015年 Youjuke. All rights reserved.
//

#import "ZJStaticFunction.h"

#define KALERTVIEWTAG    99*99*99
#define KALERTTIME        2.0f


@implementation ZJStaticFunction
+(void)alertView:(UIView *)view msg:(NSString *)msg{
    if([view viewWithTag:KALERTVIEWTAG] == nil){
        ZJAlertView *alertView = [ZJAlertView alertViewInView:view getMessage:msg kind:NO x:view.bounds.size.width y:view.bounds.size.height-60];
        
        [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:KALERTTIME];
    }
}
+(void)alertView:(UIView *)view msg:(NSString *)msg  leng:(int )le{
    if([view viewWithTag:KALERTVIEWTAG] == nil){
        ZJAlertView *alertView = [ZJAlertView alertViewInView:view getMessage:msg kind:NO x:view.bounds.size.width y:view.bounds.size.height+le];
        [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:KALERTTIME];
    }
}
+(void)addAlertView:(UIView *)view msg:(NSString *)mag{
    if([view viewWithTag:KALERTVIEWTAG] == nil){
        [ZJAlertView alertViewInView:view getMessage:mag kind:YES x:view.bounds.size.width y:view.bounds.size.height-60];
    }
}

+(void)removeAlertView:(UIView *)view{
    if([view isKindOfClass:[ZJAlertView class]])
    {
        [(ZJAlertView *)view removeView];
    }
    else{
        [[view viewWithTag:KALERTVIEWTAG] removeFromSuperview];
    }
}

//文本设置行间距
+(NSAttributedString*)textSetLineSpace:(NSString*)text{
    if (!text) {
        text = @"";
    }
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}
//根据文本计算有行间距的高度
+(CGFloat)textHeight:(NSString*)text font:(UIFont*)font showWidth:(CGFloat)showWidth {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    if (!text) {
        
        return 0;
    }
    //计算单个字的高度
    CGSize size = [text sizeWithAttributes:dic];
    CGFloat wordHeight = size.height;
    
    //计算总高度
    CGSize  actualsize = CGSizeZero;
    actualsize =[text  boundingRectWithSize:CGSizeMake(showWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    
    CGFloat colomNumber = actualsize.height/wordHeight;
    
    CGFloat offset = colomNumber * 8;
    CGFloat totalH = wordHeight*colomNumber+offset;
    return totalH;
}


/*
 判断一个字符串是否包含另一个字符串
 */
+(BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString{
    if ([motherString rangeOfString:sonString].location!=NSNotFound) {
        
        return YES;
    }else {
        return NO;
    }
}

/*
 去除空字符
 */
+(NSString *)trimSpaceInTextField:(NSString *)str{
    
    //return  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //字符串通过整理字符 stringByTrimmingCharactersInSet 函数过滤字符串中的特殊符号 去除空格
    //    使用NSString中的stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]方法只是去掉左右两边的空格；
    
    
    //    使用NSString *strUrl = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];可以去掉空格，注意此时生成的strUrl是autorelease属性的，不要妄想对strUrl进行release操作。
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

/*
 判断请求状态是否成功
 */
+(BOOL)isCurrectResult:(NSDictionary *)dic{
    if([ZJStaticFunction isBlank:[dic objectForKey:@"status"]]){
        return NO;//9.27 ycf
    }
    return [[dic objectForKey:@"status"] intValue]==200;
}

/**
 *	@brief	判断对象是否为空、NULL、nil
 *
 *	@param 	obj 	对象
 *
 *	@return	返回BOOL值
 */
+(BOOL)isBlank:(id)obj
{
    if(obj == [NSNull null] || obj == nil)return YES;
    if([obj isKindOfClass:[NSArray class]])
        return [obj count]==0;
    if([obj isKindOfClass:[NSMutableArray class]])
        return [obj count]==0;
    if([obj isKindOfClass:[NSDictionary class]])
        return [obj count]==0;
    if([obj isKindOfClass:[NSMutableDictionary class]])
        return [obj count]==0;
    if([obj isKindOfClass:[NSData class]])
        return [obj length]==0;
    if([obj isKindOfClass:[NSString class]])
        return [obj length]==0;
    return NO;
}

//把get请求的URL的参数转化成字典
+(NSDictionary*)jsonGetUrlParam:(NSString*)urlStr{
    NSRange range = [urlStr rangeOfString:@"?"];
    NSString *getParam = [urlStr substringFromIndex:range.location+1];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *array;
    if ([getParam rangeOfString:@"&"].location != NSNotFound) {
        array = [getParam componentsSeparatedByString:@"&"];
    }else{
        array = @[getParam];
    }
    
    for (NSString *obj in array) {
        NSArray *subArray = [obj componentsSeparatedByString:@"="];
        if (subArray.count>1) {
            [result setValue:subArray[1] forKey:subArray[0]];
        }else{
            [result setValue:@"" forKey:subArray[0]];
        }
    }
    
    return result;
    
}

/***************************/
//字符串转数组
+(NSArray *)getArrayByJsonString:(NSString *)str{
    return [self getArrayByJsonString:str encoding:NSUTF8StringEncoding];
}

//字符串转字典
+(NSDictionary *)getDictionaryByJsonString:(NSString *)str{
    
    return [self getDictionaryByJsonString:[str substringFromIndex: [str rangeOfString:@"{"].location] encoding:NSUTF8StringEncoding];
}

+(NSDictionary *)getDictionaryByJsonString:(NSString *)str encoding:(NSStringEncoding)encoding{
    
    
    if([ZJStaticFunction isBlank:str])return nil;
    if(!encoding)return nil;
    NSData *JSONData = [self getJSONDataFromString:str encoding:encoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
}
+(NSArray *)getArrayByJsonString:(NSString *)str encoding:(NSStringEncoding)encoding{
    if([ZJStaticFunction isBlank:str])return nil;
    if(!encoding)return nil;
    NSData *JSONData = [self getJSONDataFromString:str encoding:encoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
}

+(NSData *)getJSONDataFromString:(NSString *)str encoding:(NSStringEncoding)encoding{
    if([ZJStaticFunction isBlank:str])return nil;
    if(!encoding)return nil;
    return [str dataUsingEncoding:encoding];
}
+(NSString *)getJsonStringByArray:(NSArray *)array encoding:(NSStringEncoding)encoding{
    if(![array isKindOfClass:[NSArray class]])return nil;
    if(!encoding)return nil;
    NSData *JSONData = [self getJSONDataFromObject:array];
    return [[NSString alloc] initWithData:JSONData encoding:encoding];
}
+(NSString *)getJsonStringByDictionary:(NSDictionary *)dictionary encoding:(NSStringEncoding)encoding{
    if([ZJStaticFunction isBlank:dictionary])return nil;
    if(!encoding)return nil;
    NSData *JSONData = [self getJSONDataFromObject:dictionary];
    return [[NSString alloc] initWithData:JSONData encoding:encoding];
}

+(NSData *)getJSONDataFromObject:(id)obj{
    if(!obj)return nil;
    
    if([NSJSONSerialization isValidJSONObject:obj]){
        
        NSError *error = nil;
        
        return [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        
        
    }
    
    return nil;
}

/**************************/
/*
 请求数据转换
 */
+(NSDictionary *)JsonData:(MKNetworkOperation *)request{
    
    NSData *_data=[request responseData];
    //    NSString *afertEncoder=[[NSString alloc] initWithData:_data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
    //    NSDictionary *data=[afertEncoder JSONValue];
    NSString *afertEncoder=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSDictionary *data=(NSDictionary*)[afertEncoder JSONString];
    
    return data;
    
}

/**猪猪添加 若去除符号“.”后长度大与3（10.2.0或1.10.0），该方法需重写*/
+(int)versionToInt:(NSString*)str
{
    str = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (str.length<3) {
        str = [NSString stringWithFormat:@"%@0",str];
        int temp =[self versionToInt:str];
        str = [NSString stringWithFormat:@"%d",temp];
    }
    
    return [str intValue];
    
}


/*
 判断网络
 */
+(BOOL)isUserNetOK{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
/*
 判断手机号
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,170,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[031678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,170,171,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,170,177,180,181,189
     */
    NSString *CT = @"^1(3[34]|53|7[07]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/*
 验证是否是邮件
 */
+(BOOL)isValidateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

//将图片处理成圆的
+(UIImage *)changeimagetocilce:(UIImage*)image
{
    UIImage *finalImage = nil;
    UIGraphicsBeginImageContext(image.size);
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGAffineTransform trnsfrm = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0, -1.0));
        trnsfrm = CGAffineTransformConcat(trnsfrm, CGAffineTransformMakeTranslation(0.0, image.size.height));
        CGContextConcatCTM(ctx, trnsfrm);
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height));
        CGContextClip(ctx);
        CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return finalImage;
}
/*
 开启打电话功能
 */
+(UIView*)callTelephone :(NSString *)phone{
    [ZJStaticFunction callPalmShop];
    
    //    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phone]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    //
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    
    // NSLog(@"phone%@",phone);
    //
    UIWebView * view =[[UIWebView alloc]init];
    //
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    //    //    // 貌似tel:// 或者 tel: 都行
    [view loadRequest:[NSURLRequest requestWithURL:telURL]];
    //    //    //记得添加到view上
    return view;
    
    
}
/*
 判断是否支持打电话
 */
+(void)callPalmShop{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    //NSString *deviceType = [UIDevice currentDevice].modellocalizedModel;
    
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){//
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil,nil];
        
        [alert show];
        return;
        
    }
  
}


+(NSString *)ShowErrorMessage:(NSString *)str{
    
    NSString *errorStr= [ZJStaticFunction isBlank:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"errorCode" ofType:@"plist"]]objectForKey:str]]?@"服务器异常":[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"errorCode" ofType:@"plist"]]objectForKey:str];
    
    return errorStr;
    
}
+(void)copyWeibo{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =@"";
}
+(void)copyWeixin{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =@"";
    
}
@end
