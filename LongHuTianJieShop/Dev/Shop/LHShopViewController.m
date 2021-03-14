//
//  LHShopViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHShopViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import "LHCommonDefine.h"
#import "LHWindowManager.h"
#import "UIViewAdditions.h"
#import "LHMapLocationManager.h"


@interface LHShopViewController () <BMKMapViewDelegate>
@property(nonatomic,strong) BMKMapView *mapView;
@property(nonatomic,strong) UIButton *locationButton;
@end

@implementation LHShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self locationOnce];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
}

- (void)setupMapView {
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT - [LHWindowManager shareInstance].currentNavigationController.tabBarController.tabBar.height)];
    self.mapView.delegate = self;
    [self.mapView setZoomLevel:17];
    self.mapView.showMapScaleBar = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.baseIndoorMapEnabled = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeHeading;
    [self.view addSubview:self.mapView];

    self.locationButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.mapView.bottom - 20 - 40, 40, 40)];
    self.locationButton.backgroundColor = [UIColor whiteColor];
    self.locationButton.layer.cornerRadius = 4;
    self.locationButton.layer.masksToBounds = YES;
    [self.locationButton addTarget:self action:@selector(locationOnce) forControlEvents:UIControlEventTouchUpInside];
    UIImage *locationImage = [UIImage imageNamed:@"location_icon"];
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:locationImage highlightedImage:locationImage];
    locationImageView.width = 32;
    locationImageView.height = 32;
    locationImageView.center = CGPointMake(20,20);
    [self.locationButton addSubview:locationImageView];
    [self.view addSubview:self.locationButton];
}

- (void)locationOnce {
    WeakSelf;
    [[LHMapLocationManager shareInstance] requestLocationWithCompletionBlock:^{
        StrongSelf;
        [self.mapView updateLocationData:[LHMapLocationManager shareInstance].userLocation];
        self.mapView.centerCoordinate = [LHMapLocationManager shareInstance].userLocation.location.coordinate;
        [self.mapView setZoomLevel:17];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end
