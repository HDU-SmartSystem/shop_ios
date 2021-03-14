//
//  LHMapLocationManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHMapLocationManager.h"
#import "LHCommonDefine.h"

@interface LHMapLocationManager () <BMKLocationManagerDelegate>
@end

@implementation LHMapLocationManager
+ (instancetype)shareInstance {
    static LHMapLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHMapLocationManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLocation];
    }
    return self;
}

- (void)setupLocation {
    self.userLocation = [[BMKUserLocation alloc] init];
    self.locationManager = [[BMKLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.locationTimeout = 15;
    self.locationManager.reGeocodeTimeout = 15;
}

- (void)requestLocationWithCompletionBlock:(void(^)(void))completion {
    WeakSelf;
    [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        StrongSelf;
        if(location.location) {
            self.userLocation.location = location.location;
            CGFloat latitude = location.location.coordinate.latitude;
            CGFloat longitude = location.location.coordinate.longitude;
            NSLog(@"latitude = %f,longitude = %f",latitude,longitude);
            if(completion) {
                completion();
            }
        }
    }];
}

@end
