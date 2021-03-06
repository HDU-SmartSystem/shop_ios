//
//  LHBaseViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHBaseViewController.h"
#import "LHWindowManager.h"
#import "LHCommonDefine.h"
#import "UIViewAdditions.h"
#import "UIColor+LHExtention.h"

@interface LHBaseViewController ()
@end

@implementation LHBaseViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self setupNavbar];
}

- (void)setupNavbar {
    CGFloat topInset = [[LHWindowManager shareInstance] window].safeAreaInsets.top + 44;
    self.customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topInset)];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customNavBar];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15, self.customNavBar.bottom - 24 - 10, 24, 24)];
    [leftButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:leftButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.customNavBar.bottom - 28 - 8, SCREEN_WIDTH - 80, 28)];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.customNavBar addSubview:self.titleLabel];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
