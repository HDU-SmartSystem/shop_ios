//
//  LHShopDetailSubViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/8.
//

#import "LHShopDetailSubViewController.h"
#import "LHShopDetailSubViewModel.h"
#import "LHCommonDefine.h"
#import "LHHorizontalPagingView.h"

@interface LHShopDetailSubViewController ()
@property(nonatomic,strong) LHShopDetailSubViewModel *viewModel;
@property(nonatomic,assign) LHShopDetailSubType listType;
@property(nonatomic,copy) NSDictionary* params;
@end

@implementation LHShopDetailSubViewController

-(instancetype)initWithListType:(LHShopDetailSubType)type params:(nullable NSDictionary *)params {
    if(self = [super init]) {
        self.listType = type;
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];

    self.tableView = [[LHHorizontalTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0 , *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
}

- (void)setupViewModel {
    self.viewModel = [[LHShopDetailSubViewModel alloc] initWithViewController:self tableView:self.tableView listType:self.listType params:self.params];
}

- (void)updatePagingView:(LHHorizontalPagingView *)pagingView {
    [self.viewModel updatePagingView:pagingView];
}


@end
