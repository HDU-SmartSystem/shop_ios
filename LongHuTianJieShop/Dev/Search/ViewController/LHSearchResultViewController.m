//
//  LHSearchResultViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchResultViewController.h"
#import "LHShopListViewController.h"
#import "UIViewAdditions.h"
#import "LHCommonDefine.h"
#import "LHWindowManager.h"

@interface LHSearchResultViewController ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@end

@implementation LHSearchResultViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]) {
        self.params = params;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeSearch params:self.params];
    [self.view addSubview:self.shopListVC.view];
    [self.shopListVC updateFrame:CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height - [[LHWindowManager shareInstance] window].safeAreaInsets.bottom)];
}

@end
