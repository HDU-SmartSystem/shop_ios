//
//  LHSeachItemCollectionCell.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHSeachItemCollectionCell : UICollectionViewCell
+ (CGSize)sizeForData:(id)data;
- (void)refreshWithData:(id)data;

@end
@interface LHSeachItemCollectionCellModel : NSObject
@property(nonatomic,copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
