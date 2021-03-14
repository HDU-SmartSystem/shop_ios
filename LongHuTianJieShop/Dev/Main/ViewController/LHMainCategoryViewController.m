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
#import "LHShopListFilterView.h"
#import "LHShopListFilterListView.h"

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
    [self setupFilterData];
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


- (void)setupFilterData {
    LHShopListFilterItemModel *categoryModel = [[LHShopListFilterItemModel alloc] init];
    categoryModel.name = @"分类";
    LHShopListFilterListItemModel *itemModel1 = [[LHShopListFilterListItemModel alloc] init];
    itemModel1.itemName = @"服装";
    LHShopListFilterListItemModel *itemModel2 = [[LHShopListFilterListItemModel alloc] init];
    itemModel2.itemName = @"运动";
    LHShopListFilterListItemModel *itemModel3 = [[LHShopListFilterListItemModel alloc] init];
    itemModel3.itemName = @"玩具";
    categoryModel.items = @[itemModel1,itemModel2,itemModel3];

    LHShopListFilterItemModel *sortModel = [[LHShopListFilterItemModel alloc] init];
    sortModel.name = @"排序";
    LHShopListFilterItemModel *filterModel = [[LHShopListFilterItemModel alloc] init];
    filterModel.name = @"筛选";
    NSArray *filterArray = @[categoryModel,sortModel,filterModel];
    NSMutableDictionary *param = [self.params mutableCopy];
    param[@"filter_data"] = filterArray;
    self.params = param;
}

- (void)jumpToSearch {
    NSString *openURL = @"sslocal://search";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"title"] = @"龙湖天街";
    params[@"category"] = self.params[@"category"];
    [[LHRoute shareInstance] pushViewControllerWithURL:openURL params:params];
}


@end
