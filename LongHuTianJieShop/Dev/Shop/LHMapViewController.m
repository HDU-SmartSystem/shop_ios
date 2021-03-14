//
//  LHMapViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "LHCommonDefine.h"
#import "LHWindowManager.h"
#import "UIViewAdditions.h"

@interface LHMapViewController () <BMKMapViewDelegate>
@property(nonatomic,strong) BMKMapView *mapView;
@end

@implementation LHMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
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
    [self.view addSubview:self.mapView];
}


@end
