//
//  LHLauchManger.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHLauchManger : NSObject
+ (instancetype)shareInstance;
- (void)processAtBegin;
@end

NS_ASSUME_NONNULL_END
