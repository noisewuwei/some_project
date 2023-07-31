//
//  SuiViewController.m
//  FRun
//
//  Created by noise on 2016/11/7.
//  Copyright © 2016年 noisecoder. All rights reserved.
//
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SuiViewController.h"
#import "Define.h"
#import "GradientPolylineOverlay.h"
#import "JZLocationConverter.h"
#import "GradientPolylineRenderer.h"

@interface SuiViewController (){
    BOOL _tracking;
    UIImage *SImage;
}

@end

@implementation SuiViewController

- (CLLocationManager *)localManager
{
    if (_localManager == nil)
    {
        _localManager = [[CLLocationManager alloc]init];
        
        //设置定位的精度
        [_localManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //位置信息更新最小距离
        _localManager.distanceFilter = 10;
        _localManager.activityType = CLActivityTypeFitness;
        
        //设置代理
        _localManager.delegate = self;
        
//        //因为 requestAlwaysAuthorization 是 iOS8 后提出的,需要添加一个是否能响应的条件判断,防止崩溃
//        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined && [_localManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [_localManager requestAlwaysAuthorization];
//        }
        
        //创建存放位置的数组
        _smoothTrackArray = [[NSMutableArray alloc] init];
    }
    return _localManager;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"随心跑";
    [self createBarLeftWithImage:@"Back.png"];
    
    self.follower = [Follower new];
    self.follower.delegate = self;
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, zScreenWidth, zScreenHeight-64)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.clipsToBounds = YES;
    
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    
    [self.localManager startUpdatingLocation];
    
    [self.view addSubview:self.mapView];
    
    
    
    
//    self.maskView = [UIView new];
//    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
//    [self.mapView addSubview:self.maskView];
//    
//    self.avatarImageView = [UIImageView new];
//    self.avatarImageView.image = [UIImage imageNamed:@"avatar"];
//    self.avatarImageView.clipsToBounds = YES;
//    self.avatarImageView.layer.cornerRadius = 30.0;
//    self.avatarImageView.layer.borderWidth = 1.0;
//    self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    [self.maskView addSubview:self.avatarImageView];
//    
//    self.dateLabel = [UILabel new];
//    self.dateLabel.text = @"July 17th, 2015";
//    self.dateLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:19];
//    self.dateLabel.textColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0];
//    [self.maskView addSubview:self.dateLabel];
//    
//    self.cycleImageView = [UIImageView new];
//    self.cycleImageView.image = [UIImage imageNamed:@"cycle"];
//    [self.maskView addSubview:self.cycleImageView];
    
    self.trackingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.trackingButton.frame = CGRectMake(zScreenWidth-65, 15+64, 50, 50);
    self.trackingButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.trackingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [self.trackingButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.trackingButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.trackingButton];
    
    self.timeView = [[MetricView alloc] initWithImage:[UIImage imageNamed:@"time"] title:@"时长" color:[UIColor whiteColor]];
    self.timeView.frame = CGRectMake(15, zScreenHeight-TScreenWidth-5, TScreenWidth, TScreenWidth);
    self.timeView.backgroundColor = MainColor;
    
    self.averageSpeedView = [[MetricView alloc] initWithImage:[UIImage imageNamed:@"avgSpeed"] title:@"均速" color:[UIColor whiteColor]];
    self.averageSpeedView.frame = CGRectMake(15+TScreenWidth+15+15+TScreenWidth, zScreenHeight-TScreenWidth-5, TScreenWidth, TScreenWidth);
    self.averageSpeedView.backgroundColor = MainColor;
    
    self.distanceView = [[MetricView alloc] initWithImage:[UIImage imageNamed:@"distance"] title:@"里程" color:[UIColor whiteColor]];
    self.distanceView.frame = CGRectMake(15+TScreenWidth+15, zScreenHeight-TScreenWidth-5, TScreenWidth, TScreenWidth);
    self.distanceView.backgroundColor = MainColor;
    
    self.timeView.hidden = YES;
    self.distanceView.hidden = YES;
    self.averageSpeedView.hidden = YES;
    
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.distanceView];
    [self.view addSubview:self.averageSpeedView];
    
    // Do any additional setup after loading the view.
}


#pragma mark - Follower

- (void)start {
    
    self.timeView.hidden = NO;
    self.distanceView.hidden = NO;
    self.averageSpeedView.hidden = NO;
    
    [self.trackingButton setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self.trackingButton removeTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.trackingButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.follower beginRouteTracking];
    self.mapView.showsUserLocation = YES;
}

- (void)stop {
    [self createRightTitle:@"保存" titleColor:BtnColor];
    self.trackingButton.hidden = YES;
    [self.localManager stopUpdatingHeading];
    _tracking = NO;
    
    self.timeView.hidden = NO;
    self.distanceView.hidden = NO;
    self.averageSpeedView.hidden = NO;
    
    [self.trackingButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.trackingButton removeTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.trackingButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.follower endRouteTracking];
    
    [_mapView addOverlay:self.follower.routePolyline];
    [_mapView setRegion:self.follower.routeRegion animated:YES];
    
    self.mapView.showsUserLocation = NO;
}

- (void)followerDidUpdate:(Follower *)follower {
    
    self.timeView.valueLabel.text = [follower routeDurationString];
    NSLog(@"%@",[follower routeDurationString]);
    if ([follower totalDistanceWithUnit:DistanceUnitKilometers]<0) {
        self.distanceView.valueLabel.text = @"0.00 km";
    }else{
        self.distanceView.valueLabel.text = [NSString stringWithFormat:@"%.2f km", [follower totalDistanceWithUnit:DistanceUnitKilometers]];
    }
    NSLog(@"%f",[follower totalDistanceWithUnit:DistanceUnitKilometers]);
    if ([follower averageSpeedWithUnit:SpeedUnitKilometersPerHour]<0) {
        self.averageSpeedView.valueLabel.text = @"0.00 km/h";
    }else{
        self.averageSpeedView.valueLabel.text = [NSString stringWithFormat:@"%.2f km/h", [follower averageSpeedWithUnit:SpeedUnitKilometersPerHour]];
    }
    NSLog(@"%f",[follower averageSpeedWithUnit:SpeedUnitKilometersPerHour]);
}



#pragma mark - Map view delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
//    
//    if([overlay isKindOfClass:[GradientPolylineOverlay class]]){
//        //轨迹
//        GradientPolylineRenderer *polylineRenderer = [[GradientPolylineRenderer alloc] initWithOverlay:overlay];
//        polylineRenderer.lineWidth = 5.f;
//        return polylineRenderer;
//    }
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor = [UIColor colorWithRed:250/255.0 green:90/255.0 blue:45/255.0 alpha:1.0];
    renderer.strokeColor = [UIColor colorWithRed:250/255.0 green:90/255.0 blue:45/255.0 alpha:1.0];
    renderer.lineWidth = 5;
    return renderer;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    NSString *latitude = [NSString stringWithFormat:@"%3.5f",userLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%3.5f",userLocation.coordinate.longitude];
    NSLog(@"更新的用户位置:纬度:%@, 经度:%@",latitude,longitude);
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
//    放大地图到自身的经纬度位置。
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005));
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000);
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
//    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [mapView setRegion:region animated:YES];
    
    if (_tracking) {
        if (_smoothTrackArray.count != 0) {
            
            //从位置数组中取出最新的位置数据
            NSString *locationStr = _smoothTrackArray.lastObject;
            NSArray *temp = [locationStr componentsSeparatedByString:@","];
            NSString *latitudeStr = temp[0];
            NSString *longitudeStr = temp[1];
            CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([latitudeStr doubleValue], [longitudeStr doubleValue]);
            
            //当前确定到的位置数据
            CLLocationCoordinate2D endCoordinate;
            endCoordinate.latitude = userLocation.coordinate.latitude;
            endCoordinate.longitude = userLocation.coordinate.longitude;
            
            //移动距离的计算
            double meters = [self calculateDistanceWithStart:startCoordinate end:endCoordinate];
            NSLog(@"移动的距离为%f米",meters);
            
            //为了美化移动的轨迹,移动的位置超过10米,方可添加进位置的数组
            if (meters >= 0){
                
                NSLog(@"添加进位置数组");
                NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude, userLocation.coordinate.longitude];
                [_smoothTrackArray addObject:locationString];
                
                //开始绘制轨迹
                CLLocationCoordinate2D pointsToUse[2];
                pointsToUse[0] = startCoordinate;
                pointsToUse[1] = endCoordinate;
                //调用 addOverlay 方法后,会进入 rendererForOverlay 方法,完成轨迹的绘制
                MKPolyline *lineOne = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
                [_mapView addOverlay:lineOne];
                
            }else{
                
                NSLog(@"不添加进位置数组");
            }
        }else{
            
            //存放位置的数组,如果数组包含的对象个数为0,那么说明是第一次进入,将当前的位置添加到位置数组
            NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.coordinate.latitude, userLocation.coordinate.longitude];
            [_smoothTrackArray addObject:locationString];
        }

    }
}

//计算距离
- (double)calculateDistanceWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end {
    
    double meter = 0;
    
    double startLongitude = start.longitude;
    double startLatitude = start.latitude;
    double endLongitude = end.longitude;
    double endLatitude = end.latitude;
    
    double radLatitude1 = startLatitude * M_PI / 180.0;
    double radLatitude2 = endLatitude * M_PI / 180.0;
    double a = fabs(radLatitude1 - radLatitude2);
    double b = fabs(startLongitude * M_PI / 180.0 - endLongitude * M_PI / 180.0);
    
    double s = 22 * asin(sqrt(pow(sin(a/2),2) + cos(radLatitude1) * cos(radLatitude2) * pow(sin(b/2),2)));
    s = s * 6378137;
    
    meter = round(s * 10000) / 10000;
    return meter;
}


-(void)showRight:(UIButton *)sender{
    if ([self isCanUsePhotos]) {
        [self save];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"轨迹已保存至“个人域-轨迹空间”！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 191;
        [alert show];
    }else{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }

    
}

- (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)save{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@",dateString);
    
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(0, 64*[UIScreen mainScreen].scale, zScreenWidth*[UIScreen mainScreen].scale, (zScreenHeight-64)*[UIScreen mainScreen].scale);//创建矩形框
    SImage=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([viewImage CGImage], rect)];
    
    //设置一个图片的存储路径
    NSString *imagePath = [NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),dateString];
//    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/FRun.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(SImage) writeToFile:imagePath atomically:YES];
    
//    UIImageWriteToSavedPhotosAlbum(SImage, nil, nil, nil);  //保存到相册中

    
}

#pragma mark - Utils

- (UILabel *)newLabelWithColor:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
