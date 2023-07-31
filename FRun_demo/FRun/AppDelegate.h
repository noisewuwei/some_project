//
//  AppDelegate.h
//  FRun
//
//  Created by noise on 2016/11/5.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property(nonatomic) CLLocationManager *locationManager;

- (void)saveContext;


@end

