//
//  VideoSaveHelper.m
//  ToDesk
//
//  Created by zuler on 2021/11/2.
//

#import "VideoSaveHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFAudio/AVFAudio.h>
#import "TD_OpusDecoder.h"
#import "TD_ScreenNetworkList.h"
#import "TD_ScreenNetwork.h"
#import "Center.pbObjc.h"
#import "TD_RecordServer.h"
#import "libyuv.h"

@interface VideoSaveHelper (){
    CMSampleBufferRef sampleBuffer;
}

@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterAudioInput;
@property (nonatomic, assign) BOOL canWrite;
@property (nonatomic, assign) Float64 startTime;
@property (nonatomic, assign) int audioCount;
@property (nonatomic, assign) NSTimeInterval timeOffset;

@property (nonatomic , strong) NSMutableArray *imageArr;

@end

@implementation VideoSaveHelper

static VideoSaveHelper* instance;
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VideoSaveHelper alloc] init];
    });
    return instance;
}

- (instancetype)init{
    
    if (self = [super init]) {
        self.canWrite = NO;
        self.startTime = 0;
        self.audioCount = 0;
    }
    return self;
    
}

- (void)creatVideoWriterWithWidth:(int)width andHeight:(int)height{
    
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeOffset = [nowDate timeIntervalSince1970];

    NSString *filePathStr = [NSString stringWithFormat:@"file:///Users/Shared/test%f.mp4",timeOffset];

    NSURL *url = [NSURL URLWithString:filePathStr];

    self.assetWriter = [AVAssetWriter assetWriterWithURL:url fileType:AVFileTypeMPEG4 error:nil];

    //写入视频大小
    NSInteger numPixels = width * height;

    //每像素比特
    CGFloat bitsPerPixel = 12.0;
    NSInteger bitsPerSecond = numPixels * bitsPerPixel;

    // 码率和帧率设置
    NSDictionary *compressionProperties = @{ AVVideoAverageBitRateKey : @(bitsPerSecond),
                                             AVVideoExpectedSourceFrameRateKey : @(15),
                                             AVVideoMaxKeyFrameIntervalKey : @(15),
                                             AVVideoProfileLevelKey : AVVideoProfileLevelH264BaselineAutoLevel };

    //视频属性
    NSDictionary *videoCompressionSettings = @{ AVVideoCodecKey : AVVideoCodecTypeH264,
                                       AVVideoWidthKey : @(width * 2),
                                       AVVideoHeightKey : @(height * 2),
                                       AVVideoScalingModeKey : AVVideoScalingModeResizeAspect,
                                       AVVideoCompressionPropertiesKey : compressionProperties };

    self.assetWriterVideoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoCompressionSettings];
    //expectsMediaDataInRealTime 必须设为yes，需要从capture session 实时获取数据
    self.assetWriterVideoInput.expectsMediaDataInRealTime = YES;

    // 音频设置
    NSDictionary *audioCompressionSettings = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                              [NSNumber numberWithFloat:48000], AVSampleRateKey,
                                              [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
                                              [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
                                              [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
                                              [NSNumber numberWithBool:YES], AVLinearPCMIsBigEndianKey,
                                              [NSNumber numberWithUnsignedInteger:2], AVNumberOfChannelsKey,
                                              nil];

    self.assetWriterAudioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioCompressionSettings];
//    self.assetWriterAudioInput.expectsMediaDataInRealTime = YES;

    if ([self.assetWriter canAddInput:self.assetWriterVideoInput])
    {
        [self.assetWriter addInput:self.assetWriterVideoInput];
    }
    else
    {
        NSLog(@"AssetWriter videoInput append Failed");
    }

    if ([self.assetWriter canAddInput:self.assetWriterAudioInput])
    {
        [self.assetWriter addInput:self.assetWriterAudioInput];
    }
    else
    {
        NSLog(@"AssetWriter audioInput Append Failed");
    }

    [self.assetWriter startWriting];

}

- (void)appendVideoSampleBuffer:(CVPixelBufferRef)image withTime:(Float64)ctime{
    
    CMFormatDescriptionRef formatDescription;

    OSStatus result = CMVideoFormatDescriptionCreateForImageBuffer(NULL, image, &formatDescription);
    NSParameterAssert(result == 0 && formatDescription != NULL);

    CMSampleBufferRef buffer;
    CMSampleTimingInfo timingInfo;
    timingInfo.duration = kCMTimeInvalid;
    timingInfo.decodeTimeStamp = kCMTimeInvalid;
    timingInfo.presentationTimeStamp = CMTimeMakeWithSeconds(ctime, 600);


    result = CMSampleBufferCreateForImageBuffer(kCFAllocatorDefault, image, true, nil, nil, formatDescription, &timingInfo, &buffer);
    NSParameterAssert(result == 0 && buffer != NULL);

    CFArrayRef attachments = CMSampleBufferGetSampleAttachmentsArray(buffer, YES);
    CFMutableDictionaryRef dict = (CFMutableDictionaryRef)CFArrayGetValueAtIndex(attachments, 0);
    CFDictionarySetValue(dict, kCMSampleAttachmentKey_DisplayImmediately, kCFBooleanTrue);

    if (!self.canWrite) {
        [self.assetWriter startSessionAtSourceTime:CMTimeMakeWithSeconds(0, 1)];
        self.canWrite = YES;
    }

    sampleBuffer = buffer;

    if ([self.assetWriterVideoInput isReadyForMoreMediaData]) {
        [self.assetWriterVideoInput appendSampleBuffer:buffer];
    }
}

- (void)appendAudioSampleBuffer:(NSMutableArray *)arr withTime:(Float64)time{
    
    int channels = 2;
    AudioStreamBasicDescription format = {0};
    format.mSampleRate = 48000;
    format.mFormatID = kAudioFormatLinearPCM;
    format.mFormatFlags =  kAudioFormatFlagIsSignedInteger | kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked;
    format.mChannelsPerFrame = channels;
    format.mBitsPerChannel = 16;
    format.mFramesPerPacket = 1;
    format.mBytesPerFrame = format.mBitsPerChannel / 8 * format.mChannelsPerFrame;
    format.mBytesPerPacket = format.mBytesPerFrame * format.mFramesPerPacket;
    format.mReserved = 0;

    if (self.startTime == 0) {
        self.startTime = time;
    }

    for (int i = 0;i < arr.count; i++) {

        CMBlockBufferRef blockBuf = NULL;
        CMSampleBufferRef cmBuf = NULL;
        CMAudioFormatDescriptionRef audioFormatDesc;

        NSData * pcmData = [[TD_OpusDecoder share] pcmDataWithAudioData:arr[i]];

        OSStatus status = CMBlockBufferCreateWithMemoryBlock(kCFAllocatorDefault,
                                                             [pcmData bytes],
                                                             [pcmData length],
                                                             kCFAllocatorNull,
                                                             NULL,
                                                             0,
                                                             [pcmData length],
                                                             0,
                                                             &blockBuf);

        if (status != noErr)
        {
            NSLog(@"CMBlockBufferCreateWithMemoryBlock error");

        }


        status = CMAudioFormatDescriptionCreate(kCFAllocatorDefault,
                                                &format,
                                                0,
                                                NULL,
                                                0,
                                                NULL,
                                                NULL,
                                                &audioFormatDesc
                                                );

        status = CMAudioSampleBufferCreateWithPacketDescriptions(kCFAllocatorDefault,
                                                                 blockBuf,
                                                                 TRUE,
                                                                 0,
                                                                 NULL,
                                                                 audioFormatDesc,
                                                                 pcmData.length/4,
                                                                 CMTimeMakeWithSeconds(self.startTime+(0.02*self.audioCount), NSEC_PER_SEC),
                                                                 NULL,
                                                                 &cmBuf);
        if (status != noErr)
        {
            NSLog(@"CMSampleBufferCreate error");

        }

        if ([self.assetWriterAudioInput isReadyForMoreMediaData]) {
            [self.assetWriterAudioInput appendSampleBuffer:cmBuf];
            NSLog(@"====count%d====length%lu====time%f",self.audioCount,(unsigned long)[pcmData length],self.startTime+(0.02*self.audioCount));
        }

        self.audioCount++;

    }
    

}

- (void)stopSession{
    
    [self.assetWriter endSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
    [self.assetWriter finishWritingWithCompletionHandler:^{

    }];
    
}

@end
