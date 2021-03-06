//
//  LHWindowManager.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHWindowManager : NSObject
+ (instancetype)shareInstance;
- (UIWindow *)window;
- (UINavigationController *)currentNavigationController;
@end

NS_ASSUME_NONNULL_END
