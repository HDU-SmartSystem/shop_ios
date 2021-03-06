//
//  LHMapLocationManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHMapLocationManager.h"
#import "LHCommonDefine.h"

NSString *LHMapPoiSearchNotification = @"lh_map_poi_serach";
@interface LHMapLocationManager () <BMKLocationManagerDelegate,BMKPoiSearchDelegate>
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
    
    self.poiSearch = [[BMKPoiSearch alloc] init];
    self.poiSearch.delegate = self;
    
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

- (void)serachWithName:(NSString *)name {
    BMKPOINearbySearchOption *nearbyOption = [[BMKPOINearbySearchOption alloc] init];
    nearbyOption.keywords = @[name];
    //????????????????????????????????????
    nearbyOption.location = [LHMapLocationManager shareInstance].userLocation.location.coordinate;
    //??????????????????????????????
    nearbyOption.radius = 1000;
    
    //???????????????????????????????????????????????????????????????????????????false???
    nearbyOption.isRadiusLimit = NO;
    //????????????????????????0???0??????????????????1??????????????????????????????
    nearbyOption.pageIndex = 0;
    //????????????POI??????????????????10????????????????????????20??????
    nearbyOption.pageSize = 10;
    [self.poiSearch poiSearchNearBy:nearbyOption];
}

-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if(errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *poiAnnotation = [NSMutableArray array];
        for (BMKPoiInfo *poiInfo in poiResult.poiInfoList) {
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = poiInfo.pt;
            annotation.title = poiInfo.name;
            [poiAnnotation addObject:annotation];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:LHMapPoiSearchNotification object:nil userInfo:@{@"annotation":poiAnnotation}];
    }
}

@end
