//
//  ShareDataModel.h
//  BuldingMall
//
//  Created by Jion on 2016/10/26.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareDataModel : NSObject
//图片url
@property(nonatomic,copy)NSString  *share_image;
//标题
@property(nonatomic,copy)NSString  *share_title;
//内容
@property(nonatomic,copy)NSString  *share_desc;
//分享的链接
@property(nonatomic,copy)NSString  *share_link;

@end
