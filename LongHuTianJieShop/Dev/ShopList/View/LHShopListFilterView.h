//
//  LHShopListFilterView.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHShopListFilterItemModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *filterCategory;
@property(nonatomic,copy) NSArray *items;
@end

@interface LHShopListFilterView : UIView
- (instancetype)initWithTableView:(UITableView *)tableView viewController:(UIViewController *)viewController;
- (void)updateWithArray:(NSArray *)itemArray;
@end


@interface LHShopListFilterItemCollectionCell : UICollectionViewCell
- (void)refreshWithData:(id)data;
@end

NS_ASSUME_NONNULL_END
