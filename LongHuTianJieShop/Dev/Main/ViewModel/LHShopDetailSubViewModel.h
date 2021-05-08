//
//  LHShopDetailSubViewModel.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHShopDetailSubViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHShopDetailSubViewModel : NSObject
-(instancetype)initWithViewController:(LHShopDetailSubViewController *)viewController tableView:(UITableView *)tableView listType:(LHShopDetailSubType)type params:(NSDictionary *)params;
- (void)updatePagingView:(LHHorizontalPagingView *)pagingView;
@end

NS_ASSUME_NONNULL_END
