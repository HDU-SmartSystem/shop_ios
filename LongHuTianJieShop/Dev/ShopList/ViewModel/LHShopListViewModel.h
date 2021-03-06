//
//  LHShopListViewModel.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHShopListViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHShopListViewModel : NSObject
- (instancetype)initWithTableView:(UITableView *)tableView listType:(LHShopListType)type params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
