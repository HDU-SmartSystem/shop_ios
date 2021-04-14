//
//  LHSettingViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/15.
//

#import "LHSettingViewModel.h"
#import "UIColor+LHExtention.h"
#import "UIFont+LHExtention.h"
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"
#import "LHCommonDefine.h"
#import "LHAccoutManager.h"
#import "LHWindowManager.h"

@interface LHSettingViewModel () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@end

@implementation LHSettingViewModel

- (instancetype)initWithTableView:(UITableView *)tableView {
    if(self = [super init]){
        self.tableView = tableView;
        [self configTableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess) name:kLHLogoutSuccessNotification object:nil];
    }
    return self;
}

-(void)configTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.tableFooterView = [[LHSettingFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 54)];
    [self.tableView registerClass:[LHSettingCell class] forCellReuseIdentifier:NSStringFromClass([LHSettingCellModel class])];

    NSArray *dataArray = @[@"账号与安全",@"通用",@"欢迎评分",@"关于我们",@"隐私",@"意见反馈"];
    NSMutableArray *dataList = [NSMutableArray array];
    for(NSString *text in dataArray) {
        LHSettingCellModel *model = [[LHSettingCellModel alloc] init];
        model.text = text;
        [dataList addObject:model];
    }
    self.dataList = dataList;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHSettingCellModel *model = [self.dataList objectAtIndex:index];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LHSettingCellModel class]) forIndexPath:indexPath];
        if(cell == nil) {
            cell = [[LHSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LHSettingCellModel class])];
        }
        if([cell isKindOfClass:[LHSettingCell class]]) {
            [(LHSettingCell *)cell refreshWithData:model];
        }
        return cell;
    }
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)logoutSuccess {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[LHWindowManager shareInstance].currentNavigationController popViewControllerAnimated:YES];
    });
}

@end

@implementation LHSettingCellModel
@end


@interface LHSettingCell ()
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIView *lineView;
@end
@implementation LHSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 0, 20)];
    self.label.font = [UIFont themeFontRegular:16];
    self.label.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.label];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5, SCREEN_WIDTH - 15, 0.5)];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.contentView addSubview:self.lineView];
}

- (void)refreshWithData:(id)data {
    if([data isKindOfClass:[LHSettingCellModel class]]) {
        LHSettingCellModel *model = (LHSettingCellModel *)data;
        self.label.text = model.text;
        self.label.width = [model.text widthWithFont:[UIFont themeFontRegular:16] height:20];
    }
}


@end


@interface LHSettingFooterView ()
@property(nonatomic,strong) UIButton *logoutButton;
@end

@implementation LHSettingFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    self.logoutButton.backgroundColor = [UIColor whiteColor];
    self.logoutButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.logoutButton setTitleColor:[UIColor colorWithHexString:@"#EC5A40"] forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:[UIColor colorWithHexString:@"#EC5A40"] forState:UIControlStateHighlighted];
    [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"退出当前账号" forState:UIControlStateHighlighted];
    [self addSubview:self.logoutButton];
}

- (void)logout {
    [[LHAccoutManager shareInstance] logout];
}

@end
