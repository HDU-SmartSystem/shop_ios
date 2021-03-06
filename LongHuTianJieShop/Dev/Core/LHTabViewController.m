//
//  LHTabViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHTabViewController.h"
#import "LHMainViewController.h"
#import "LHNavigationController.h"
#import "LHMineViewController.h"
#import "LHShopViewController.h"
#import "LHRecommendViewController.h"
#import "LHCommonDefine.h"
#import "LHWindowManager.h"
#import "UIViewAdditions.h"
#import "UIColor+LHExtention.h"

@interface LHTabViewController ()

@end

@implementation LHTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49 + [[LHWindowManager shareInstance] window].safeAreaInsets.bottom)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    [self.tabBar setUnselectedItemTintColor:[UIColor colorWithHexString:@"#666666"]];
    [self.tabBar setTintColor:[UIColor colorWithHexString:@"#ff5500"]];
    [self addNavVC];
}

- (void)addNavVC {
    LHMainViewController *mainVC = [[LHMainViewController alloc] init];
    LHNavigationController *mainNavVC = [[LHNavigationController alloc] initWithRootViewController:mainVC];
    mainNavVC.tabBarItem.image = [UIImage imageNamed:@"main_icon_normal"];
    mainNavVC.tabBarItem.selectedImage = [UIImage imageNamed:@"main_icon_selected"];
    mainNavVC.tabBarItem.title = @"首页";
    [self addChildViewController:mainNavVC];
    
    LHShopViewController *shopVC = [[LHShopViewController alloc] init];
    LHNavigationController *shopNavVC = [[LHNavigationController alloc] initWithRootViewController:shopVC];
    shopNavVC.tabBarItem.image = [UIImage imageNamed:@"shop_icon_normal"];
    shopNavVC.tabBarItem.selectedImage = [UIImage imageNamed:@"shop_icon_selected"];
    shopNavVC.tabBarItem.title = @"商场";
    [self addChildViewController:shopNavVC];
    
    LHRecommendViewController *recommendVC = [[LHRecommendViewController alloc] init];
    LHNavigationController *recommendNavVC = [[LHNavigationController alloc] initWithRootViewController:recommendVC];
    recommendNavVC.tabBarItem.image = [UIImage imageNamed:@"recommand_icon_normal"];
    recommendNavVC.tabBarItem.selectedImage = [UIImage imageNamed:@"recommand_icon_selected"];
    recommendNavVC.tabBarItem.title = @"精品推荐";
    [self addChildViewController:recommendNavVC];
    
    LHMineViewController *mineVC = [[LHMineViewController alloc] init];
    LHNavigationController *mineNavVC = [[LHNavigationController alloc] initWithRootViewController:mineVC];
    mineNavVC.tabBarItem.image = [UIImage imageNamed:@"mine_icon_normal"];
    mineNavVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_icon_selected"];
    mineNavVC.tabBarItem.title = @"我的";
    [self addChildViewController:mineNavVC];
}

@end
