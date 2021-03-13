//
//  LHMainCategoryViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHMainCategoryViewController.h"
#import "LHShopListViewController.h"
#import "LHCommonDefine.h"
#import "LHWindowManager.h"
#import "UIViewAdditions.h"

@interface LHMainCategoryViewController ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@end

@implementation LHMainCategoryViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]) {
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupViewModel];
}

- (void)setupView {
    NSString *title = self.params[@"title"];
    self.titleLabel.text = title;
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 24 - 15, self.customNavBar.bottom - 24 - 10, 24, 24)];
    [searchButton setImage:[UIImage imageNamed:@"main_search_icon"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"main_search_icon"] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(jumpToSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:searchButton];
}

- (void)setupViewModel {
    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeCategory params:self.params];
    [self.view addSubview:self.shopListVC.view];
    [self.shopListVC updateFrame:CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height - [[LHWindowManager shareInstance] window].safeAreaInsets.bottom)];
}

- (void)jumpToSearch {
    NSString *openURL = @"sslocal://search";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"title"] = @"龙湖天街";
    params[@"category"] = self.params[@"category"];
    [[LHRoute shareInstance] pushViewControllerWithURL:openURL params:params];
}


@end
