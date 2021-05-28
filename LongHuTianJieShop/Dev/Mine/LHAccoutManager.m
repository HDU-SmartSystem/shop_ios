//
//  LHAccoutManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHAccoutManager.h"
#import "LHCommonDefine.h"
#import "LHToastManager.h"

@interface LHAccoutManager ()
@property(nonatomic,assign) BOOL loginStatus;
@end

@implementation LHAccoutManager

+ (instancetype)shareInstance {
    static LHAccoutManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHAccoutManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginStatus = NO;
    }
    return self;
}

-(BOOL)isLogin {
    return self.loginStatus;
}

- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord {
    WeakSelf;
    [LHAPI requestLoginWithUserName:userName passWord:passWord completion:^(JSONModel * _Nonnull model) {
        StrongSelf;
        if([model isKindOfClass:[LHUserModel class]]) {
            LHUserModel *userModel = (LHUserModel *)model;
            if([userModel.code integerValue] == 0) {
                self.user = userModel.data;
                self.loginStatus = YES;
                [[NSUserDefaults standardUserDefaults] setObject:[self.user toDictionary] forKey:@"user"];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLHLoginSuccessNotification object:nil userInfo:nil];
                [[LHToastManager shareInstance] showToastWithText:@"登录成功"];
            } else {
                [[LHToastManager shareInstance] showToastWithText:userModel.message];
            }
        }
    }];
}

- (void)loadUserData {
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if(user) {
        self.user = [[LHUserDataModel alloc] initWithDictionary:user error:nil];
    }
    if(self.user) {
        self.loginStatus = YES;
    }
}

-(void)logout {
    self.loginStatus = NO;
    self.user = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLHLogoutSuccessNotification object:nil userInfo:nil];
}

@end
