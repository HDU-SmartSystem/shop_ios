//
//  LHSearchHistoryView.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import <UIKit/UIKit.h>
#import "LHSeachItemCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LHSearchType) {
    LHSearchTypeHistory,
    LHSearchTypeRecommend
};

@interface LHSearchHistoryView : UIView
@property(nonatomic,assign) LHSearchType type;
@property(nonatomic,copy) void(^deleteBlock)(void);
@property(nonatomic,copy) void(^selectBlock)(LHSeachItemCollectionCellModel *model);
- (void)refreshWithArray:(NSArray *)dataArray;
- (void)updateTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
