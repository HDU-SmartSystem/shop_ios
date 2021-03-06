//
//  LHMainViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHMainViewModel.h"
#import "LHCommonDefine.h"
#import "UIColor+LHExtention.h"
#import "UIViewAdditions.h"

@interface LHMainViewModel () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation LHMainViewModel

-(instancetype)initWithTableView:(UITableView *)tableView {
    if(self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}


@end
