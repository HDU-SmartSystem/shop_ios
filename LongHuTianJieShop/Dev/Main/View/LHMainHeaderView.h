//
//  LHMainHeaderView.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LHHeaderCollectionViewFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,assign) NSUInteger numberOfLine;
@end


@interface LHHeaderItemCollectionCell : UICollectionViewCell
+ (CGSize)sizeForData:(id)data;
- (void)refreshWithData:(id)data;
@end

@interface LHHeaderItemCollectionCellModel : NSObject
@property(nonatomic,copy) NSString *imageName;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *category;
@end

@interface LHMainHeaderView : UIView
@end

NS_ASSUME_NONNULL_END
