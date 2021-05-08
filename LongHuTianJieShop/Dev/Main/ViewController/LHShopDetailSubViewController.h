//
//  LHShopDetailSubViewController.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/8.
//

#import <UIKit/UIKit.h>
#import "LHHorizontalPagingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LHShopDetailSubType) {
    LHShopDetailSubGoods,
    LHShopDetailSubComments,
};

@interface LHShopDetailSubViewController : UIViewController
@property(nonatomic,strong) UITableView *tableView;
- (void)updatePagingView:(LHHorizontalPagingView *)pagingView;
- (instancetype)initWithListType:(LHShopDetailSubType)type params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
