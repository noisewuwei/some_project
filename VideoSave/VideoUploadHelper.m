//
//  VideoSaveHelper.m
//  ToDesk
//
//  Created by zuler on 2021/11/2.
//

#import "VideoUploadHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFAudio/AVFAudio.h>
#import "TD_OpusDecoder.h"
#import "XDXVideoEncoder.h"
#import "XDXAduioEncoder.h"
#import "AACEncoder.h"
#import "TD_ScreenNetworkList.h"
#import "TD_ScreenNetwork.h"
#import "Center.pbObjc.h"
#import "TD_RecordServer.h"
#import "Record.pbobjc.h"
#import "libyuv.h"

@interface VideoUploadHelper ()<XDXVideoEncoderDelegate>{
    CMSampleBufferRef sampleBuffer;
}

@property (nonatomic, assign) BOOL canWrite;
@property (nonatomic, assign) int audioCount;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, assign) Float64 startTime;


@property (nonatomic, strong) XDXVideoEncoder *videoEncoder;
@property (nonatomic, strong) XDXAduioEncoder *audioEncoder;

@property (nonatomic , strong) AACEncoder *mAudioEncoder;

@property (nonatomic , strong) NSMutableArray *imageArr;

@end

@implementation VideoUploadHelper

static VideoUploadHelper* instance;
+ (instancetype)share {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VideoUploadHelper alloc] init];
    });
    return instance;
}

- (instancetype)init{
    
    if (self = [super init]) {
        self.canWrite = NO;
        self.audioCount = 0;
        self.mAudioEncoder = [[AACEncoder alloc] init];
        
        NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        self.timeOffset = [nowDate timeIntervalSince1970];
        
    }
    return self;
    
}

- (void)creatVideoUploaderWithWidth:(int)width andHeight:(int)height{
    
    self.imageArr = [NSMutableArray array];
    
    self.videoEncoder = [[XDXVideoEncoder alloc] initWithWidth:width
                                                        height:height
                                                           fps:30
                                                       bitrate:2048
                                       isSupportRealTimeEncode:NO
                                                   encoderType:XDXH264Encoder]; // XDXH264Encoder
    self.videoEncoder.delegate = self;
    [self.videoEncoder configureEncoderWithWidth:width height:height];
    

    [[TD_RecordServer share] connectRecordSever];

}

- (void)upLoadVideoBuffer:(CVPixelBufferRef)image withTime:(Float64)ctime{
        
    if (self.imageArr.count < 30) {

        [self.imageArr addObject:(__bridge id _Nonnull)(image)];

    }else{

        self.audioCount++;

        NSLog(@"%d",self.audioCount);

        for (int i = 0; i<self.imageArr.count; i++) {

            [self.videoEncoder startEncodeDataWithPixelBuffer:(__bridge CVImageBufferRef _Nonnull)(self.imageArr[i]) withTimeStamp:CMTimeMakeWithSeconds(ctime, 600) isNeedFreeBuffer:NO];
            
        }

        [self.imageArr removeAllObjects];

    }
    
}

- (void)upLoadAudioBuffer:(NSMutableArray *)arr withTime:(Float64)time{

// upload to server
    
//    if (self.startTime == 0) {
//        self.startTime = time;
//    }
//
//    for (int i = 0;i < arr.count; i++) {
//
//        NSData * pcmData = [[TD_OpusDecoder share] pcmDataWithAudioData:arr[i]];
//
//        [self.mAudioEncoder encodeSampleBuffer:pcmData withTime:self.startTime+(0.02*self.audioCount) completionBlock:^(NSData *encodedData, NSError *error, Float64 stampTime) {
//            // upload data
//            if (encodedData != NULL) {
//                NSLog(@"******%@******%f",encodedData,stampTime);
//
//                RAudioFormat *fmsg = [RAudioFormat message];
//                fmsg.rnChannels = 2;
//
//                RAudioPacket *packet = [RAudioPacket message];
//                packet.rdata = encodedData;
//                packet.rpackindex = self.audioCount;
//                packet.rencodetype = 1;
//                packet.rraudioFormat = fmsg;
//
//                [[TD_RecordServer share] sendMsg:4 message:packet];
//
//            }
//
//        }];
//
//        self.audioCount++;
//
//    }

}


- (void)receiveVideoEncoderData:(XDXVideEncoderDataRef)dataRef {
    
    RVideoPacket *packet = [RVideoPacket message];
    packet.rpackindex = self.timeOffset;
    packet.rencodetype = 4;
    packet.rdata = [NSData dataWithBytes:(const void *)dataRef->data length:dataRef->size];
    
    [[TD_RecordServer share] sendMsg:3 message:packet];

}


@end
