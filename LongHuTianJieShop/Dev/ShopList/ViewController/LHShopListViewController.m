//
//  LHShopListViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHShopListViewController.h"
#import "LHShopListViewModel.h"
#import "UIColor+LHExtention.h"

@interface LHShopListViewController ()
@property(nonatomic,strong) LHShopListViewModel *viewModel;
@property(nonatomic,assign) LHShopListType listType;
@property(nonatomic,copy) NSDictionary* params;
@end

@implementation LHShopListViewController

-(instancetype)initWithListType:(LHShopListType)type params:(nullable NSDictionary *)params {
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0 , *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self.view addSubview:self.tableView];
}

- (void)setupViewModel {
    self.viewModel = [[LHShopListViewModel alloc] initWithViewController:self tableView:self.tableView listType:self.listType params:self.params];
}

-(void)updateFrame:(CGRect)frame {
    self.view.frame = frame;
    self.tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

@end
