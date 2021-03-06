//
//  LHRoute.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LHRouteProtocol <NSObject>

- (instancetype)initWithParams:(NSDictionary *)params;
@end

@interface LHRoute : NSObject
+ (instancetype)shareInstance;
- (void)pushViewControllerWithURL:(NSString *)url params:(nullable NSDictionary *)params;
//- (BOOL)canOpenWithURL:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
