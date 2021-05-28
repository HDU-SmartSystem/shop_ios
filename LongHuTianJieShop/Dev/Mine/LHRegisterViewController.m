//
//  LHRegisterViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/17.
//

#import "LHRegisterViewController.h"
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
#import "LHShopCaptChaModel.h"


@interface LHRegisterViewController ()
@property(nonatomic,strong) UIButton *closeButton;
@property(nonatomic,strong) UITextField *usernameInput;
@property(nonatomic,strong) UITextField *passwordInput;
@property(nonatomic,strong) UITextField *captchaInput;
@property(nonatomic,strong) UIButton *registerButton;
@end

@implementation LHRegisterViewController

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
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
    titleLabel.text = @"用户注册";
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
    
    self.captchaInput = [[UITextField alloc] initWithFrame:CGRectMake(20, self.passwordInput.bottom + 20, SCREEN_WIDTH - 40, 20)];
    self.captchaInput.font = [UIFont themeFontRegular:16];
    self.captchaInput.textColor = [UIColor blackColor];
    self.captchaInput.tintColor = [UIColor blackColor];
    cleanButton = [self.captchaInput valueForKey:@"_clearButton"];
    [cleanButton setImage:[UIImage imageNamed:@"serach_input_clear"] forState:UIControlStateNormal];
    self.captchaInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    attrPlaceHolder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:attrDict];
    self.captchaInput.attributedPlaceholder = attrPlaceHolder;
    [self.view addSubview:self.captchaInput];
    
    UIView *captchaLineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.captchaInput.bottom + 15, SCREEN_WIDTH - 40, 0.5)];
    captchaLineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.view addSubview:captchaLineView];
    
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, captchaLineView.bottom + 50, SCREEN_WIDTH - 40, 50)];
    self.registerButton.backgroundColor = [UIColor colorWithHexString:@"#ff5500"];
    self.registerButton.layer.cornerRadius = self.registerButton.height / 2.0f;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
    [self.view addSubview:self.registerButton];
    
    [self.registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close {
    [[LHWindowManager shareInstance].currentNavigationController popViewControllerAnimated:YES];
}

- (void)registerClick {
    NSString *userName = self.usernameInput.text;
    NSString *passWord = self.passwordInput.text;
    NSString *captcha = self.captchaInput.text;
    if(userName.length) {
        if(captcha.length==0) {
            [LHAPI requestCaptchaWithPhone:userName completion:^(JSONModel * _Nonnull model) {
                if([model isKindOfClass:[LHShopCaptChaModel class]]) {
                    LHShopCaptChaModel *captchaModel = (LHShopCaptChaModel *) model;
                    [[LHToastManager shareInstance] showToastWithText:captchaModel.data time:4];
                }
            }];
        } else {
            [LHAPI requestCaptchaWithPhone:userName code:captcha password:passWord completion:^(JSONModel * _Nonnull model) {
                if([model isKindOfClass:[LHShopCaptChaModel class]]) {
                    LHShopCaptChaModel *captchaModel = (LHShopCaptChaModel *) model;
                    NSString *msg = nil;
                    if([captchaModel.code integerValue] == 0) {
                        msg = @"注册成功";
                    } else {
                        msg = captchaModel.data;
                    }
                    [[LHToastManager shareInstance] showToastWithText:msg time:2];
                    if([captchaModel.code integerValue] == 0) {
                        [self registerSuccess];
                    }
                }
            }];
            
        }
    } else {
        [[LHToastManager shareInstance] showToastWithText:@"请输入手机号" time:2];
    }
}

- (void)registerSuccess {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[[LHWindowManager shareInstance] currentNavigationController] popViewControllerAnimated:YES];
    });
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end
