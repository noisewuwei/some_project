//
//  LibyuvTool.m
//  LFLiveKitDemo
//
//  Created by 蒋天宝 on 2021/4/15.
//  Copyright © 2021 admin. All rights reserved.
//

#import "LibyuvTool.h"


typedef struct {
    int width;
    int height;
    kPixelBufferFormat format;
} YMPixelBufferPoolDesc;

typedef struct {
    YMPixelBufferPoolDesc poolDesc;
    int threshold;
} YMPixelBufferDesc;

#pragma mark - YMPixelBufferPool
@interface YMPixelBufferPool : NSObject

@property (nonatomic) CFMutableDictionaryRef pools;
@property (nonatomic) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary *poolMaps;

@end

@implementation YMPixelBufferPool

- (void)dealloc {
    [self.lock lock];
    if (_pools) {
        CFDictionaryRemoveAllValues(_pools);
        CFRelease(_pools);
    }
    [self.lock unlock];
}

+ (instancetype)sharedPool {
    static YMPixelBufferPool *pool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pool = [YMPixelBufferPool new];
    });
    return pool;
}

- (instancetype)init {
    if (self = [super init]) {
        _pools = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _poolMaps = @{}.mutableCopy;
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (CVPixelBufferPoolRef)pixelBufferPoolWithDesc:(YMPixelBufferPoolDesc)poolDesc {
    OSType type;
    NSString *suffix;
    switch (poolDesc.format) {
        case kPixelBufferFormat_I420:
            /*kCVPixelFormatType_420YpCbCr8PlanarFullRange 在iOS11上面显示不出来*/
            type = kCVPixelFormatType_420YpCbCr8Planar;
            suffix = @"i420";
            break;
        case kPixelBufferFormat_BGRA:
            type = kCVPixelFormatType_32BGRA;
            suffix = @"bgra";
            break;
        case kPixelBufferFormat_NV12:
            type = kCVPixelFormatType_420YpCbCr8BiPlanarFullRange;
            suffix = @"nv12";
            break;
    }

    NSString *key = [NSString stringWithFormat:@"%d_%d_%@", poolDesc.width, poolDesc.height, suffix];

    [self.lock lock];
    CVPixelBufferPoolRef pool = (CVPixelBufferPoolRef)CFDictionaryGetValue(self.pools, (__bridge const void *)(key));
    if (pool == NULL) {
        NSDictionary *att = @{
            (NSString *)kCVPixelBufferPixelFormatTypeKey : @(type),
            (NSString *)kCVPixelBufferWidthKey : @(poolDesc.width),
            (NSString *)kCVPixelBufferHeightKey : @(poolDesc.height),
            (NSString *)kCVPixelBufferIOSurfacePropertiesKey : @{},
        };

        int status = CVPixelBufferPoolCreate(NULL, NULL, (__bridge CFDictionaryRef _Nullable)att, &pool);
        if (status != kCVReturnSuccess) {
            [self.lock unlock];
            return NULL;
        }
        CFDictionarySetValue(self.pools, (__bridge const void *)(key), pool);
        CVPixelBufferPoolRelease(pool);
    }
    [self.lock unlock];
    return pool;
}


- (CVPixelBufferRef)createPixelBufferFromPoolWithDesc:(YMPixelBufferDesc)bufferDesc {
    CVPixelBufferPoolRef pool = [self pixelBufferPoolWithDesc:bufferDesc.poolDesc];
    assert(pool != nil);
    if (!pool) {
        return NULL;
    }

    //create pixel buffer
    CVPixelBufferRef pixelBuffer = nil;
    NSDictionary *option = @{(NSString *)kCVPixelBufferPoolAllocationThresholdKey : @(bufferDesc.threshold) };
    CVReturn status = CVPixelBufferPoolCreatePixelBufferWithAuxAttributes(NULL, pool, (__bridge CFDictionaryRef _Nullable)(option), &pixelBuffer);

    if (status == kCVReturnWouldExceedAllocationThreshold) {
        CVPixelBufferPoolFlush(pool, kCVPixelBufferPoolFlushExcessBuffers);
        return NULL;
    }
    if (status != kCVReturnSuccess) {
        return NULL;
    }
    return pixelBuffer;
}


- (void)cleanup
{
    [self.lock lock];
    CFDictionaryRemoveAllValues(self.pools);
    [self.lock unlock];
}

- (void)flush
{
    [self.lock lock];
    CFDictionaryApplyFunction(self.pools, __applyFunction, (__bridge void *)(self));
    [self.lock unlock];
}


void __applyFunction(const void *key, const void *value, void *context)
{
    CVPixelBufferPoolRef pool = (CVPixelBufferPoolRef)value;
    CVPixelBufferPoolFlush(pool, kCVPixelBufferPoolFlushExcessBuffers);
}


@end

#pragma mark - LibyuvTool
@interface LibyuvTool ()


@end

@implementation LibyuvTool

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark Color conver
/// 将指定颜色转为指定颜色
/// @param type      转换类型
/// @param src_frame 颜色缓冲区
/// @param width     宽度
/// @param height    高度
+ (NSData *)colorConver:(kConver)type src_frame:(const uint8*)src_frame width:(int)width height:(int)height {
    int src_stride_frame = 4 * width;
    
    unsigned char * dest_buffer = (unsigned char *)malloc(width * height * 4);
    
    int result;
    switch (type) {
        case kConver_RGBAToARGB:
            result = RGBAToARGB(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
        case kConver_ABGRToARGB:
            result = ABGRToARGB(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
        case kConver_BGRAToARGB:
            result = BGRAToARGB(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
        case kConver_ARGBToABGR:
            result = ARGBToABGR(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
        case kConver_ARGBToBGRA:
            result = ARGBToBGRA(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
        case kConver_ARGBToRGBA:
            result = ARGBToRGBA(src_frame, src_stride_frame, dest_buffer, src_stride_frame, width, height);
            break;
    }
    
    if (result != 0) {
        return nil;
    }
    
    
    NSData * destData = [NSData dataWithBytes:dest_buffer length:width * height * 4];
    free(dest_buffer);
    return destData;
}

#pragma mark NV12
/// NV12转ARGB
/// @param imageBuffer CVImageBufferRef
+ (NSData *)NV12ToARGB:(CVImageBufferRef)imageBuffer {
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    int pixelWidth = (int)CVPixelBufferGetWidth(imageBuffer);
    int pixelHeight = (int)CVPixelBufferGetHeight(imageBuffer);
    
    uint8_t *y_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    uint8_t *uv_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 1);

    int src_stride_y = (int)CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    int src_stride_uv = (int)CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 1);
    
    unsigned char * dest_buffer = (unsigned char *)malloc(pixelWidth * pixelHeight * 4);
    int dst_stride_argb = 4 * pixelWidth;
    
    NV12ToARGB(y_frame, src_stride_y, uv_frame, src_stride_uv, dest_buffer, dst_stride_argb, pixelWidth, pixelHeight);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    NSData * destData = [NSData dataWithBytes:dest_buffer length:pixelWidth * pixelHeight * 4];
    free(dest_buffer);
    
    return destData;
}

/// ARGB转NV12
/// @param src_frame ARGB
/// @param width     宽度
/// @param height    高度
+ (CVPixelBufferRef)ARGBToNV12:(const uint8*)src_frame
                     nv12Pixel:(CVPixelBufferRef)nv12Pixel
                         width:(int)width height:(int)height {
    if (!nv12Pixel) {
        return nil;
    }
    
    uint8_t * temp_y_frame;
    uint8_t * temp_uv_frame;
    int temp_stride_y;
    int temp_stride_uv;
    [self nv12PixelBuffer:nv12Pixel
                  y_frame:&temp_y_frame src_stride_y:&temp_stride_y
                 uv_frame:&temp_uv_frame src_stride_uv:&temp_stride_uv
                    width:nil height:nil];

    int result = ARGBToNV12(src_frame, width * 4, temp_y_frame, temp_stride_y, temp_uv_frame, temp_stride_uv, width, height);
    
    if (result == 0) {
        return nv12Pixel;
    } else {
        return nil;
    }
}

/// 构建CVPixelBufferRef
/// 注意：使用完后记得释放CVPixelBufferRelease(nv12Pixel);
/// @param format 构建类型
/// @param width 宽度
/// @param height 高度
+ (CVPixelBufferRef)pixelBufferWithFormat:(kPixelBufferFormat)format width:(int)width height:(int)height {
    
    YMPixelBufferPoolDesc poolDesc = {0};
    poolDesc.width = width;
    poolDesc.height = height;
    poolDesc.format = format;

    YMPixelBufferDesc desc = {.poolDesc = poolDesc, .threshold = 50};
    
    CVPixelBufferRef dstPixelBuffer = [[YMPixelBufferPool sharedPool] createPixelBufferFromPoolWithDesc:desc];
    if (!dstPixelBuffer) {
        return nil;
    }
    return dstPixelBuffer;
}

/// 获取NV12的相关数据
+ (void)nv12PixelBuffer:(CVPixelBufferRef)nv12PixelBuffer
                y_frame:(uint8_t **)y_frame src_stride_y:(int *)src_stride_y
               uv_frame:(uint8_t **)uv_frame src_stride_uv:(int *)src_stride_uv
                  width:(int *)width height:(int *)height {
    if (CVPixelBufferGetPixelFormatType(nv12PixelBuffer) != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange &&
        CVPixelBufferGetPixelFormatType(nv12PixelBuffer) != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
        return;
    }
    CVPixelBufferLockBaseAddress(nv12PixelBuffer, 0);
    if (width) {
        *width = (int)CVPixelBufferGetWidth(nv12PixelBuffer);
    }
    if (height) {
        *height = (int)CVPixelBufferGetHeight(nv12PixelBuffer);
    }
    if (src_stride_y) {
        *src_stride_y = (int)CVPixelBufferGetBytesPerRowOfPlane(nv12PixelBuffer, 0);
    }
    if (src_stride_uv) {
        *src_stride_uv = (int)CVPixelBufferGetBytesPerRowOfPlane(nv12PixelBuffer, 1);
    }
    if (y_frame) {
        *y_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(nv12PixelBuffer, 0);
    }
    if (uv_frame) {
        *uv_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(nv12PixelBuffer, 1);
    }
    CVPixelBufferUnlockBaseAddress(nv12PixelBuffer, 0);
}

/// 获取I420的相关数据
+ (BOOL)i420PixelBuffer:(CVPixelBufferRef)i420PixelBuffer
                y_frame:(uint8_t **)y_frame src_stride_y:(int *)src_stride_y
                u_frame:(uint8_t **)u_frame src_stride_u:(int *)src_stride_u
                v_frame:(uint8_t **)v_frame src_stride_v:(int *)src_stride_v
                  width:(int *)width height:(int *)height {
    if (CVPixelBufferGetPixelFormatType(i420PixelBuffer) != kCVPixelFormatType_420YpCbCr8Planar) {
        return NO;
    }
    CVPixelBufferLockBaseAddress(i420PixelBuffer, 0);
    if (width) {
        *width = (int)CVPixelBufferGetWidth(i420PixelBuffer);
    }
    if (height) {
        *height = (int)CVPixelBufferGetHeight(i420PixelBuffer);
    }
    if (y_frame) {
        *y_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(i420PixelBuffer, 0);
    }
    if (u_frame) {
        *u_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(i420PixelBuffer, 1);
    }
    if (v_frame) {
        *v_frame = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(i420PixelBuffer, 2);
    }
    if (src_stride_y) {
        *src_stride_y = (int)CVPixelBufferGetBytesPerRowOfPlane(i420PixelBuffer, 0);
    }
    if (src_stride_u) {
        *src_stride_u = (int)CVPixelBufferGetBytesPerRowOfPlane(i420PixelBuffer, 1);
    }
    if (src_stride_v) {
        *src_stride_v = (int)CVPixelBufferGetBytesPerRowOfPlane(i420PixelBuffer, 2);
    }
    
    CVPixelBufferUnlockBaseAddress(i420PixelBuffer, 0);
    return YES;
}

#pragma mark Conver
+ (void)ARGBToABGR:(unsigned char *)argb width:(int)width height:(int)height {
    unsigned int * argbBuffer = (unsigned int *)argb;
    for (int i = 0; i < width * height; i++) {
        argbBuffer[i] = (argbBuffer[i] & 0xFF000000) |         // AA______ ==> AA______
                        ((argbBuffer[i] & 0x00FF0000) >> 16) | // __RR____ ==> ______RR
                        (argbBuffer[i] & 0x0000FF00) |         // ____GG__ ==> ____GG__
                        ((argbBuffer[i] & 0x000000FF) << 16);  // ______BB ==> __BB____
    }
}

+ (void)ABGRToARGB:(unsigned char *)abgr width:(int)width height:(int)height {
    unsigned int * bgraBuffer = (unsigned int *)abgr;
    for (int i = 0; i < width * height; i++) {
        bgraBuffer[i] = (bgraBuffer[i] & 0xFF000000) |         // AA______ ==> AA______
                        ((bgraBuffer[i] & 0x00FF0000) >> 16) | // __BB____ ==> ______BB
                        (bgraBuffer[i] & 0x0000FF00) |         // ____GG__ ==> ____GG__
                        ((bgraBuffer[i] & 0x000000FF) << 16);  // ______RR ==> __RR____
    }
}

@end



