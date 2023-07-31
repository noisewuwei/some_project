//
//
//  
//  LearnVideoToolBox
//
//  Created by zuler on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AACEncoder : NSObject

@property (nonatomic) dispatch_queue_t encoderQueue;
@property (nonatomic) dispatch_queue_t callbackQueue;

- (void) encodeSampleBuffer:(NSData*)dataBuffer withTime:(Float64)time completionBlock:(void (^)(NSData *encodedData, NSError* error, Float64 stampTime))completionBlock;


@end
