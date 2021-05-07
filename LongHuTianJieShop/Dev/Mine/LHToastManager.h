//
//  LHToastManager.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHToastManager : NSObject
+ (instancetype)shareInstance;
- (void)showToastWithText:(NSString *)text;
- (void)showToastWithText:(NSString *)text time:(NSTimeInterval)time;
@end

NS_ASSUME_NONNULL_END
