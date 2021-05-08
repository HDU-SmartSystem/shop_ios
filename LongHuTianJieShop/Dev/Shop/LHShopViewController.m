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
#import <BNRoutePlanModel.h>
#import <BNaviService.h>

extern NSString *LHMapPoiSearchNotification;
@interface LHShopViewController () <BMKMapViewDelegate,UITextFieldDelegate,BNNaviRoutePlanDelegate>
@property(nonatomic,strong) BMKMapView *mapView;
@property(nonatomic,strong) UIButton *locationButton;
@property(nonatomic,strong) UITextField *textInput;
@property(nonatomic,strong) NSArray<BMKPointAnnotation *> *poiAnnotation;
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
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(50, [LHWindowManager shareInstance].currentNavigationController.tabBarController.tabBar.height, SCREEN_WIDTH - 100, 44)];
    searchView.backgroundColor = [UIColor whiteColor];
    UIImageView *searchIconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    searchIconView.image = [UIImage imageNamed:@"main_search_icon"];
    [searchView addSubview:searchIconView];
    
    self.textInput = [[UITextField alloc] initWithFrame:CGRectMake(44, 10, searchView.width - 44 - 10, 20)];
    self.textInput.background = NULL;
    self.textInput.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.textInput.textColor = [UIColor colorWithHexString:@"#333333"];
    self.textInput.tintColor = [UIColor colorWithHexString:@"#333333"];
    self.textInput.returnKeyType = UIReturnKeySearch;
    self.textInput.delegate = self;
    NSDictionary *attrDict = @{
        NSFontAttributeName:[UIFont themeFontRegular:14],
        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
    };
    NSAttributedString *attrPlaceHolder = [[NSAttributedString alloc] initWithString:@"搜索店铺" attributes:attrDict];
    self.textInput.attributedPlaceholder = attrPlaceHolder;
    [searchView addSubview:self.textInput];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchComplete:) name:LHMapPoiSearchNotification object:nil];

    [self.view addSubview:searchView];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = textField.text;
    [[LHMapLocationManager shareInstance] serachWithName:text];
    return YES;
}

- (void)searchComplete:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSArray<BMKPointAnnotation *> *poiAnnotation = [userInfo valueForKey:@"annotation"];
    [self.mapView removeAnnotations:self.poiAnnotation];
    [self.mapView addAnnotations:poiAnnotation];
    self.poiAnnotation = poiAnnotation;
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"%@",view.annotation.title);
}

@end
