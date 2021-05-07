//
//  LHShopDetailViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/6.
//

#import "LHShopDetailViewController.h"
#import "LHShopDetailHeaderView.h"
#import "LHCommonDefine.h"
#import "LHShopDetailModel.h"
#import "LHAPI.h"
#import "LHAccoutManager.h"

@interface LHShopDetailViewController ()
@property(nonatomic,strong) NSDictionary *params;
@property(nonatomic,strong) LHShopDetailHeaderView *headerView;
@property(nonatomic,strong) LHShopDetailModel *model;
@end


@implementation LHShopDetailViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]){
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [[LHShopDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 192)];
    [self.view addSubview:self.headerView];
    
    self.customNavBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.customNavBar];
    if([[LHAccoutManager shareInstance] isLogin]) {
        WeakSelf;
        [LHAPI reqeustShopDetailWithShopId:self.params[@"shopId"] userId:[LHAccoutManager shareInstance].user.userId completion:^(JSONModel * _Nonnull model) {
            if([model isKindOfClass:[LHShopDetailModel class]]) {
                StrongSelf;
                self.model = (LHShopDetailModel *)model;
                self.model.data.picurl = [[LHAPI host] stringByAppendingFormat:@"/images/%@",self.model.data.picurl];
                [self.headerView refreshWithModel:self.model];
            }
        }];
    } else {
        self.model = [[LHShopDetailModel alloc] init];
        self.model.data = [[LHShopDetailDataModel alloc] init];
        self.model.data.picurl = self.params[@"image"];
        self.model.data.name = self.params[@"title"];
        self.model.data.collected = NO;
        [self.headerView refreshWithModel:self.model];
    }
}


@end
