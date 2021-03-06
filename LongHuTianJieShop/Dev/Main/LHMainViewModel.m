//
//  LHMainViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHMainViewModel.h"
#import "LHAPI.h"
#import "LHShopListModel.h"
#import "LHShopListItemCell.h"
#import "LHCommonDefine.h"
#import "UIColor+LHExtention.h"
#import <MJRefresh/MJRefresh.h>
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"

@interface LHMainViewModel ()
@end

@implementation LHMainViewModel

-(instancetype)initWithTableView:(UITableView *)tableView {
    if(self = [super init]) {
    }
    return self;
}


@end
