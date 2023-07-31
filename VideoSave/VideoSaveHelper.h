//
//  VideoSaveHelper.h
//  ToDesk
//
//  Created by zuler on 2021/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoSaveHelper : NSObject

+ (instancetype)share;

- (void)creatVideoWriterWithWidth:(int)width andHeight:(int)height;

- (void)appendVideoSampleBuffer:(CVPixelBufferRef)image withTime:(Float64)ctime;

- (void)appendAudioSampleBuffer:(NSMutableArray *)dataArr withTime:(Float64)time;

- (void)stopSession;

@end

NS_ASSUME_NONNULL_END
