//
//  LHMainViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHMainViewController.h"
#import "LHMainViewModel.h"
#import "LHCommonDefine.h"
#import "UIViewAdditions.h"
#import "LHMainTopView.h"
#import "UIColor+LHExtention.h"
#import "LHRoute.h"
#import "LHWindowManager.h"
#import "LHShopListViewController.h"

@interface LHMainViewController ()
@property(nonatomic,strong) LHMainViewModel *viewModel;
@property(nonatomic,strong) LHMainTopView *topView;
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation LHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self setupViewModel];
}

- (void)setupView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    CGFloat topInset = [[LHWindowManager shareInstance] window].safeAreaInsets.top + 44;
    self.topView = [[LHMainTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topInset)];
    [self.view addSubview:self.topView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.bottom - [LHWindowManager shareInstance].currentNavigationController.tabBarController.tabBar.height)];
    
//    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeMain params:nil];
//    [self.view addSubview:self.shopListVC.view];
//    [self.shopListVC updateFrame:CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.bottom - [LHWindowManager shareInstance].currentNavigationController.tabBarController.tabBar.height)];
}

- (void)setupViewModel {
    self.viewModel = [[LHMainViewModel alloc] init];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end
