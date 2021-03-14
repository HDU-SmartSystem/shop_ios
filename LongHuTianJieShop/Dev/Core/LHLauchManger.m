//
//  LHLauchManger.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHLauchManger.h"
#import "LHSearchHistoryManager.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import "LHMapLocationManager.h"
#import "LHAccoutManager.h"

@implementation LHLauchManger

+ (instancetype)shareInstance {
    static LHLauchManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHLauchManger alloc] init];
    });
    return instance;
}


- (void)processAtBegin {
    [[LHSearchHistoryManager shareInstance] loadHistoryData];
    [self baiduMapConfigure];
    [[LHAccoutManager shareInstance] loadUserData];
}


- (void)baiduMapConfigure {
    [[BMKMapManager sharedInstance] start:@"qdDpHIIIrhSBlBInj8gsZMiMRA8Gpi37" generalDelegate:nil];
    [BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"qdDpHIIIrhSBlBInj8gsZMiMRA8Gpi37" authDelegate:nil];
    [[LHMapLocationManager shareInstance] requestLocationWithCompletionBlock:nil];
}


@end
