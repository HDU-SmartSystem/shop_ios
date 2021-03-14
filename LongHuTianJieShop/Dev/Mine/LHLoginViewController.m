//
//  LHLoginViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHLoginViewController.h"
#import "UIViewAdditions.h"
#import "UIFont+LHExtention.h"
#import "UIColor+LHExtention.h"
#import "NSString+LHExtention.h"
#import "LHWindowManager.h"
#import "LHCommonDefine.h"
#import "LHAPI.h"
#import "LHUserModel.h"
#import "LHToastManager.h"
#import "LHAccoutManager.h"

@interface LHLoginViewController ()
@property(nonatomic,strong) UIButton *closeButton;
@property(nonatomic,strong) UITextField *usernameInput;
@property(nonatomic,strong) UITextField *passwordInput;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UIButton *registerButton;
@property(nonatomic,strong) UIButton *findPasswordButton;
@end

@implementation LHLoginViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLHLoginSuccessNotification object:nil];
}

- (void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat topInset = [[LHWindowManager shareInstance] window].safeAreaInsets.top + 44;
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, topInset - 10 - 24, 24, 24)];
    [self.closeButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [self.closeButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateHighlighted];
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.closeButton.bottom + 70, 0, 40)];
    titleLabel.font = [UIFont themeFontMedium:30];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"密码登陆";
    titleLabel.width = [titleLabel.text widthWithFont:[UIFont themeFontMedium:30] height:40];
    [self.view addSubview:titleLabel];
    
    self.usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(20, titleLabel.bottom + 70, SCREEN_WIDTH - 40, 20)];
    self.usernameInput.font = [UIFont themeFontRegular:16];
    self.usernameInput.textColor = [UIColor blackColor];
    self.usernameInput.tintColor = [UIColor blackColor];
    self.usernameInput.returnKeyType = UIReturnKeyNext;
    UIButton *cleanButton = [self.usernameInput valueForKey:@"_clearButton"];
    [cleanButton setImage:[UIImage imageNamed:@"serach_input_clear"] forState:UIControlStateNormal];
    self.usernameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    NSDictionary *attrDict = @{
        NSFontAttributeName:[UIFont themeFontRegular:16],
        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
    };
    NSAttributedString *attrPlaceHolder = [[NSAttributedString alloc] initWithString:@"手机" attributes:attrDict];
    self.usernameInput.attributedPlaceholder = attrPlaceHolder;
    [self.view addSubview:self.usernameInput];
    
    UIView *usernameLineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.usernameInput.bottom + 15, SCREEN_WIDTH - 40, 0.5)];
    usernameLineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.view addSubview:usernameLineView];

    self.passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(20, usernameLineView.bottom + 20, SCREEN_WIDTH - 40, 20)];
    self.passwordInput.font = [UIFont themeFontRegular:16];
    self.passwordInput.textColor = [UIColor blackColor];
    self.passwordInput.tintColor = [UIColor blackColor];
    cleanButton = [self.passwordInput valueForKey:@"_clearButton"];
    [cleanButton setImage:[UIImage imageNamed:@"serach_input_clear"] forState:UIControlStateNormal];
    self.passwordInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    attrPlaceHolder = [[NSAttributedString alloc] initWithString:@"密码" attributes:attrDict];
    self.passwordInput.attributedPlaceholder = attrPlaceHolder;
    [self.view addSubview:self.passwordInput];
    
    UIView *passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.passwordInput.bottom + 15, SCREEN_WIDTH - 40, 0.5)];
    passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.view addSubview:passwordLineView];
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, passwordLineView.bottom + 50, SCREEN_WIDTH - 40, 50)];
    self.loginButton.backgroundColor = [UIColor colorWithHexString:@"#ff5500"];
    self.loginButton.layer.cornerRadius = self.loginButton.height / 2.0f;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
    [self.view addSubview:self.loginButton];
    
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginButton.left, self.loginButton.bottom + 15, 0, 20)];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
    self.registerButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.registerButton setTitleColor:[UIColor colorWithHexString:@"#FF9629"] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor colorWithHexString:@"#FF9629"] forState:UIControlStateHighlighted];
    [self.registerButton sizeToFit];
    [self.view addSubview:self.registerButton];
    
    self.findPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.loginButton.bottom + 15, 0, 20)];
    [self.findPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.findPasswordButton setTitle:@"找回密码" forState:UIControlStateHighlighted];
    self.findPasswordButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.findPasswordButton setTitleColor:[UIColor colorWithHexString:@"#FF9629"] forState:UIControlStateNormal];
    [self.findPasswordButton setTitleColor:[UIColor colorWithHexString:@"#FF9629"] forState:UIControlStateHighlighted];
    [self.findPasswordButton sizeToFit];
    self.findPasswordButton.right = self.loginButton.right;
    [self.view addSubview:self.findPasswordButton];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close {
    [[LHWindowManager shareInstance].currentNavigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)login {
    NSString *userName = self.usernameInput.text;
    NSString *passWord = self.passwordInput.text;
    [[LHAccoutManager shareInstance] loginWithUserName:userName passWord:passWord];
}

- (void)loginSuccess {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self close];
    });
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end
