//
//  LHMapLocationManager.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationKit/BMKLocationComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHMapLocationManager : NSObject
+ (instancetype)shareInstance;
@property(nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,strong) BMKLocationManager *locationManager;
- (void)requestLocationWithCompletionBlock:(nullable void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
