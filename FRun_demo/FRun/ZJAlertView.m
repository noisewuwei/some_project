//
//  ZJAlertView.m
//  BusinessManage
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "ZJAlertView.h"
#define KALERTVIEWTAG    99*99*99
@implementation ZJAlertView

+ (id)alertViewInView:(UIView *)aSuperview getMessage:(NSString *)message kind:(BOOL)_kind x:(float)_x y:(float)_y
{
    const CGFloat DEFAULT_LABEL_WIDTH = 140;
    const CGFloat DEFAULT_LABEL_HEIGHT = 60;
    CGRect rect = CGRectMake(_x*0.5-80,_y*0.5-70, 160, 140);
    ZJAlertView *loadingView =[[ZJAlertView alloc] initWithFrame:rect];
    if (!loadingView)
    {
        return nil;
    }
    loadingView.tag = KALERTVIEWTAG;
    loadingView.opaque = NO;
    loadingView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [aSuperview addSubview:loadingView];
    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
    UILabel *loadingLabel =
    [[UILabel alloc]
     initWithFrame:labelFrame]
    ;
    loadingLabel.text = NSLocalizedString(message, nil);
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.backgroundColor = [UIColor clearColor];
    
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    loadingLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    [loadingView addSubview:loadingLabel];
//    CGSize _size = [loadingLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]] constrainedToSize:CGSizeMake(DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT) lineBreakMode:UILineBreakModeWordWrap];
    /* 猪猪修改*/
    //根据文本信息自适应宽高
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]],NSFontAttributeName,nil];
    
    CGSize _size = [loadingLabel.text boundingRectWithSize:CGSizeMake(DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    loadingLabel.numberOfLines = 0;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    labelFrame.origin.x = 0.5 * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH);
    labelFrame.origin.y = 0.5 * (loadingView.frame.size.height -_size.height);
    labelFrame.size.height = _size.height;
    
    if(_kind){
        labelFrame.origin.y = 0.5 * (loadingView.frame.size.height -_size.height-50);
        UIActivityIndicatorView *activityIndicatorView =
        [[UIActivityIndicatorView alloc]
         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]  ;
        [loadingView addSubview:activityIndicatorView];
        
        activityIndicatorView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin|
        UIViewAutoresizingFlexibleTopMargin|
        UIViewAutoresizingFlexibleBottomMargin;
        [activityIndicatorView startAnimating];
        
        CGRect activityIndicatorRect = activityIndicatorView.frame;
        activityIndicatorRect.origin.x =
        0.5 * (loadingView.frame.size.width - activityIndicatorRect.size.width);
        activityIndicatorRect.origin.y =
        loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
        activityIndicatorView.frame = activityIndicatorRect;
        
        
    }
    loadingLabel.frame = labelFrame;
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
    return loadingView;
}

- (void)removeView
{
    UIView *aSuperview = [self superview];
    [super removeFromSuperview];
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}


- (void)drawRect:(CGRect)rect
{
    rect.size.height -= 1;
    rect.size.width -= 1;
    
    const CGFloat RECT_PADDING = 8.0;
    rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
    
    const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,
                      rect.origin.x,
                      rect.origin.y + rect.size.height - ROUND_RECT_CORNER_RADIUS);
    
    // Top left corner
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        ROUND_RECT_CORNER_RADIUS);
    
    // Top right corner
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        ROUND_RECT_CORNER_RADIUS);
    
    // Bottom right corner
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        ROUND_RECT_CORNER_RADIUS);
    
    // Bottom left corner
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,  
                        rect.origin.x,  
                        rect.origin.y,  
                        ROUND_RECT_CORNER_RADIUS);  
    
    // Close the path at the rounded rect  
    CGPathCloseSubpath(path);  
    
    CGPathRef roundRectPath = path;  
    
    CGContextRef context = UIGraphicsGetCurrentContext();  
    
    const CGFloat BACKGROUND_OPACITY = 0.7;  
    CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);  
    CGContextAddPath(context, roundRectPath);  
    CGContextFillPath(context);  
    
    CGPathRelease(roundRectPath);  
}  

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
