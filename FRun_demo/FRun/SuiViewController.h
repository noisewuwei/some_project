//
//  SuiViewController.h
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "BaseViewController.h"
#import "Follower.h"
#import "MetricView.h"
#import "GradientPolylineOverlay.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SuiViewController : BaseViewController<MKMapViewDelegate, FollowerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) Follower *follower;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *localManager;

@property (nonatomic, strong) NSMutableArray *smoothTrackArray;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *cycleImageView;
@property (nonatomic, strong) UIButton *trackingButton;
@property (nonatomic, strong) GradientPolylineOverlay *Polyline;

@property (nonatomic, strong) MetricView *timeView;
@property (nonatomic, strong) MetricView *topSpeedView;
@property (nonatomic, strong) MetricView *averageSpeedView;
@property (nonatomic, strong) MetricView *distanceView;
@property (nonatomic, strong) MetricView *averageAltitudeView;
@property (nonatomic, strong) MetricView *maxAltitudeView;


@end
