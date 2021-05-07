//
//  LHShopDetailHeaderView.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/6.
//

#import <UIKit/UIKit.h>
#import "LHShopDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHShopDetailHeaderView : UIView
- (void)refreshWithModel:(LHShopDetailModel *)model;
@end

NS_ASSUME_NONNULL_END
