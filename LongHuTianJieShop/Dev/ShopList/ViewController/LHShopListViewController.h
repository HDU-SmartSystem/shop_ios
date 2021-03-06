//
//  LHShopListViewController.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,LHShopListType) {
    LHShopListTypeMain,
    LHShopListTypeSearch,
};

@interface LHShopListViewController : UIViewController
- (void)updateFrame:(CGRect)frame;
- (instancetype)initWithListType:(LHShopListType)type params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END