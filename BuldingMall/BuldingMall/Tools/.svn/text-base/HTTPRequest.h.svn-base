//
//  HTTPRequest.h
//  BusinessManage
//
//  Created by Jion on 15/8/7.
//  Copyright (c) 2015年 Youjuke. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface HTTPRequest : MKNetworkEngine

+ (instancetype)shareIntance;
/*
 参数：url 请求地址
 params 传入参数  例如：@{@“path”:@"file"}或@{@“path”:@[@"file1",@"file2",...]}
 pathKey 上传文件的路径和key值
 HUD  加载时的提示
 vc   所在的控制器，一般为self
 result  请求返回的状态为200时的数据
 */
+(void)postWithURL:(NSString *)url params:(NSDictionary*)params filePathAndKey:(NSDictionary*)pathKey ProgressHUD:(MBProgressHUD*)HUD controller:(UIViewController*)vc response:(void(^)(id json))result error400Code:(void (^)(id failure))failureCode;
/*
 参数：url 请求地址
      params 传入参数
      HUD  加载时的提示
     vc   所在的控制器，一般为self
     result  请求返回的状态为200时的数据
 */
+(void)postWithURL:(NSString *)url params:(NSDictionary*)params ProgressHUD:(MBProgressHUD*)HUD controller:(UIViewController*)vc response:(void(^)(id json))result error400Code:(void (^)(id failure))failureCode;
@end
