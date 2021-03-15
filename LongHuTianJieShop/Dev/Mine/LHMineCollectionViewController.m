//
//  LHMineCollectionViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/15.
//

#import "LHMineCollectionViewController.h"
#import "LHShopListViewController.h"
#import "LHWindowManager.h"
#import "LHCommonDefine.h"
#import "UIViewAdditions.h"
@interface LHMineCollectionViewController ()
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@end

@implementation LHMineCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeCollection params:nil];
    [self.view addSubview:self.shopListVC.view];
    [self.shopListVC updateFrame:CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height - [[LHWindowManager shareInstance] window].safeAreaInsets.bottom)];
    self.titleLabel.text = @"我的收藏";
}


@end
