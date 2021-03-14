//
//  LHAccoutManager.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <Foundation/Foundation.h>
#import "LHUserModel.h"
#import "LHAPI.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *kLHLoginSuccessNotification = @"kLHLoginSuccessNotification";
@interface LHAccoutManager : NSObject
@property(nonatomic,strong) LHUserDataModel *user;
+ (instancetype)shareInstance;
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord;
- (void)loadUserData;
- (BOOL)isLogin;
@end

NS_ASSUME_NONNULL_END
