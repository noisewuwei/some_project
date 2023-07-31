//
//  VideoSaveHelper.h
//  ToDesk
//
//  Created by zuler on 2021/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoUploadHelper : NSObject

+ (instancetype)share;

- (void)creatVideoUploaderWithWidth:(int)width andHeight:(int)height;

- (void)upLoadVideoBuffer:(CVPixelBufferRef)image withTime:(Float64)ctime;

- (void)upLoadAudioBuffer:(NSMutableArray *)dataArr withTime:(Float64)time;

@end

NS_ASSUME_NONNULL_END
