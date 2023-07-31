//
//  URL.h
//  BuldingMall
//
//  Created by Jion on 16/9/5.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#ifndef URL_h
#define URL_h

//图片链接拼接
#define YouJuKeImageUrl(str) (([str rangeOfString:@"http://"].location != NSNotFound) ? str : [NSString stringWithFormat:@"http://bk.img.youjuke.com/product%@",(str)])

#ifdef DEBUG

#if 1
#define kHomeWebUrl  @"http://m.youjuke.com/onsale/index?platform=app"
//精选特卖
#define kJingXuanWebUrl  @"http://m.youjuke.com/onsale/oldlist?platform=app"

#else

#define kHomeWebUrl  @"http://prebk.youjuke.com/onsale/index?platform=app"
//精选特卖
#define kJingXuanWebUrl  @"http://prebk.youjuke.com/onsale/oldlist?platform=app"

#endif

#else
#define kHomeWebUrl  @"http://m.youjuke.com/onsale/index?platform=app"
//精选特卖
#define kJingXuanWebUrl  @"http://m.youjuke.com/onsale/oldlist?platform=app"

#endif

#pragma mark =====首页=====
//#define kHomeWebUrl  @"http://m.youjuke.com/onsale/index?platform=app"


#pragma mark =====现场特卖=====
#define kSaleWebUrl @"http://m.youjuke.com/jchd.html?platform=app&putin=weixin&child=fwhsc"


#pragma mark =====我的或个人中心=====


#endif /* URL_h */
