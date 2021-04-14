//
//  LHSettingViewModel.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import "LHBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHSettingViewModel : NSObject
- (instancetype)initWithTableView:(UITableView *)tableView;
@end

@interface LHSettingCellModel : NSObject
@property(nonatomic,copy) NSString *text;
@end
@interface LHSettingCell : LHBaseTableViewCell

@end

@interface LHSettingFooterView : UIView

@end

NS_ASSUME_NONNULL_END
