//
//  LHRecommendViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHRecommendViewController.h"
#import "UIColor+LHExtention.h"
#import "LHWindowManager.h"
#import "LHCommonDefine.h"
#import "LHShopListViewController.h"

@interface LHRecommendViewController ()
@property(nonatomic,strong) UIView *customNavBar;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@end

@implementation LHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self setupNavbar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shopListVC viewWillAppear:animated];
}

- (void)setupNavbar {
    CGFloat topInset = [[LHWindowManager shareInstance] window].safeAreaInsets.top + 44;
    self.customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topInset)];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customNavBar];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.customNavBar.bottom - 28 - 8, SCREEN_WIDTH - 80, 28)];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"推荐";
    [self.customNavBar addSubview:self.titleLabel];
    
    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeRecommand params:nil];
    [self.view addSubview:self.shopListVC.view];
    [self.shopListVC updateFrame:CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.bottom - [LHWindowManager shareInstance].currentNavigationController.tabBarController.tabBar.height)];
}

@end
