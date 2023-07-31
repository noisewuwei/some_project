//
//  LibyuvTool.h
//  LFLiveKitDemo
//
//  Created by 蒋天宝 on 2021/4/15.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReplayKit/ReplayKit.h>
#include "YUV/libyuv.h"

typedef NS_ENUM(NSInteger, kConver) {
    kConver_RGBAToARGB,
    kConver_ABGRToARGB,
    kConver_BGRAToARGB,
    kConver_ARGBToABGR,
    kConver_ARGBToBGRA,
    kConver_ARGBToRGBA,
};

typedef NS_ENUM(NSInteger, kPixelBufferFormat) {
    kPixelBufferFormat_NV12,
    kPixelBufferFormat_I420,
    kPixelBufferFormat_BGRA
};

@interface LibyuvTool : NSObject

#pragma mark Color conver
/// 将指定颜色转为指定颜色
/// @param type      转换类型
/// @param src_frame 颜色缓冲区
/// @param width     宽度
/// @param height    高度
+ (NSData *)colorConver:(kConver)type src_frame:(const uint8*)src_frame width:(int)width height:(int)height;

#pragma mark NV12
/// NV12转ARGB
/// @param imageBuffer CVImageBufferRef
+ (NSData *)NV12ToARGB:(CVImageBufferRef)imageBuffer;

/// ARGB转NV12
/// @param src_frame ARGB
/// @param width     宽度
/// @param height    高度
+ (CVPixelBufferRef)ARGBToNV12:(const uint8*)src_frame
                     nv12Pixel:(CVPixelBufferRef)nv12Pixel
                         width:(int)width height:(int)height;

#pragma mark CVPixelBufferRef
/// 构建CVPixelBufferRef
/// 注意：使用完后记得释放CVPixelBufferRelease(nv12Pixel);
/// @param format 构建类型
/// @param width 宽度
/// @param height 高度
+ (CVPixelBufferRef)pixelBufferWithFormat:(kPixelBufferFormat)format width:(int)width height:(int)height;

/// 获取NV12的相关数据
+ (void)nv12PixelBuffer:(CVPixelBufferRef)nv12PixelBuffer
                y_frame:(uint8_t **)y_frame src_stride_y:(int *)src_stride_y
               uv_frame:(uint8_t **)uv_frame src_stride_uv:(int *)src_stride_uv
                  width:(int *)width height:(int *)height;

/// 获取I420的相关数据
+ (BOOL)i420PixelBuffer:(CVPixelBufferRef)i420PixelBuffer
                y_frame:(uint8_t **)y_frame src_stride_y:(int *)src_stride_y
                u_frame:(uint8_t **)u_frame src_stride_u:(int *)src_stride_u
                v_frame:(uint8_t **)v_frame src_stride_v:(int *)src_stride_v
                  width:(int *)width height:(int *)height;
@end

