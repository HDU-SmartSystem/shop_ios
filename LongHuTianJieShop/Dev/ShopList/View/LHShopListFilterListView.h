//
//  LHShopListFilterListView.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <UIKit/UIKit.h>
#import "LHBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN


@interface LHShopListFilterListItemModel : NSObject
@property(nonatomic,copy) NSString *itemName;
@property(nonatomic,copy) NSString *itemValue;
@end
@interface LHShopListFilterListItemCell : LHBaseTableViewCell
@end

@interface LHShopListFilterListView : UIView
@property(nonatomic,copy) void(^clickItemBlock)(LHShopListFilterListItemModel *model);
- (void)updateWithArray:(NSArray *)itemArray;
@end

NS_ASSUME_NONNULL_END
