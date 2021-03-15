//
//  LHShopListViewController.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,LHShopListType) {
    LHShopListTypeSearch,
    LHShopListTypeCategory,
    LHShopListTypeCollection,
};

@interface LHShopListViewController : UIViewController
@property(nonatomic,strong) UITableView *tableView;
- (void)updateFrame:(CGRect)frame;
- (instancetype)initWithListType:(LHShopListType)type params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
