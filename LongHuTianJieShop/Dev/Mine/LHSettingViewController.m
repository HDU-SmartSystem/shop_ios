//
//  LHSettingViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/15.
//

#import "LHSettingViewController.h"
#import "LHSettingViewModel.h"
#import "UIColor+LHExtention.h"
#import "LHCommonDefine.h"
#import "UIViewAdditions.h"

@interface LHSettingViewController ()
@property(nonatomic,strong) LHSettingViewModel *viewModel;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation LHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupViewModel];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.titleLabel.text = @"设置";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0 , *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    self.tableView.frame = CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.bottom);
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self.view addSubview:self.tableView];
}

- (void)setupViewModel {
    self.viewModel = [[LHSettingViewModel alloc] initWithTableView:self.tableView];
}
@end
