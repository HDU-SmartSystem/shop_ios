//
//  LHMineViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHMineViewController.h"
#import "LHAccoutManager.h"
#import "UIFont+LHExtention.h"
#import "UIColor+LHExtention.h"
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"
#import "LHRoute.h"
#import "LHWindowManager.h"
#import "LHCommonDefine.h"

#define itemWidth 60
#define itemHieght 70

@interface LHMineItemView : UIView
-(void)updateWithImageName:(NSString *)name labelText:(NSString *)text;
@end


@interface LHMineViewController ()
@property(nonatomic,strong) UIButton *loginButton;
@end

@implementation LHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLHLoginSuccessNotification object:nil];
}

- (void)setupView {
    if(![[LHAccoutManager shareInstance] isLogin]) {
        self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        self.loginButton.layer.cornerRadius = 15;
        self.loginButton.layer.masksToBounds = YES;
        self.loginButton.center = self.view.center;
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
        [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"#ff5500"]];
        [self.view addSubview:self.loginButton];
        [self.loginButton addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.loginButton.hidden = YES;
        self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        CGFloat topInset = [[LHWindowManager shareInstance] window].safeAreaInsets.top + 44;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topInset + 110)];
        bgView.image = [UIImage imageNamed:@"mine_header_bg"];
        [self.view addSubview:bgView];
        
        UIImageView *settingIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 24, topInset - 10 - 24, 24, 24)];
        settingIcon.image = [UIImage imageNamed:@"setting_icon"];
        [self.view addSubview:settingIcon];
        
        UIView *mineServerView = [[UIView alloc] initWithFrame:CGRectMake(9, bgView.bottom - 30, SCREEN_WIDTH - 18, 110)];
        mineServerView.backgroundColor = [UIColor whiteColor];
        mineServerView.layer.cornerRadius = 10;
        mineServerView.layer.masksToBounds = YES;
        [self.view addSubview:mineServerView];
        
        UILabel *mineServerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 42, 20)];
        mineServerLabel.font = [UIFont themeFontMedium:16];
        mineServerLabel.textColor = [UIColor blackColor];
        mineServerLabel.text = @"我的服务";
        [mineServerView addSubview:mineServerLabel];
        
        LHMineItemView *collectView = [[LHMineItemView alloc] initWithFrame:CGRectMake(12, mineServerLabel.bottom + 10, itemWidth, itemHieght)];
        [collectView updateWithImageName:@"mine_collect" labelText:@"我的收藏"];
        [mineServerView addSubview:collectView];

    }
}

- (void)goLogin {
    [[LHRoute shareInstance] presentViewControllerWithURL:@"sslocal://login" params:nil];
}

- (void)loginSuccess {
    [self setupView];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end

@interface LHMineItemView ()
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *label;
@end

@implementation LHMineItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 32, 32)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconView.bottom + 5, itemWidth, 20)];
    self.label.font = [UIFont themeFontRegular:12];
    self.label.textColor = [UIColor colorWithHexString:@"#666666"];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.iconView];
    [self addSubview:self.label];
}

-(void)updateWithImageName:(NSString *)name labelText:(NSString *)text {
    self.iconView.image = [UIImage imageNamed:name];
    self.label.text = text;
}

@end
