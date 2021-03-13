//
//  LHShopListViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHShopListViewModel.h"
#import "LHAPI.h"
#import "LHShopListModel.h"
#import "LHShopListItemCell.h"
#import "LHCommonDefine.h"
#import "UIColor+LHExtention.h"
#import <MJRefresh/MJRefresh.h>
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"

@interface LHShopListViewModel () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) BOOL isLastSuccess;
@property(nonatomic,assign) LHShopListType listType;
@property(nonatomic,copy) NSDictionary* params;
@property(nonatomic,assign) NSInteger pageNumber;
@end

@implementation LHShopListViewModel

-(instancetype)initWithTableView:(UITableView *)tableView listType:(LHShopListType)type params:(nullable NSDictionary *)params {
    if(self = [super init]){
        self.tableView = tableView;
        self.listType = type;
        self.params = params;
        self.pageNumber = 0;
        [self configTableView];
        self.dataList = [NSMutableArray array];
        self.isLastSuccess = YES;
        [self requestData];
    }
    return self;
}

-(void)configTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[LHShopListItemCell class] forCellReuseIdentifier:NSStringFromClass([LHShopListDataModel class])];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.tableView.tableHeaderView = headerView;
    WeakSelf;
    MJRefreshAutoStateFooter *footer =  [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        StrongSelf;
        [self requestData];
        [self.tableView.mj_footer setState:MJRefreshStateIdle];
    }];
    [footer setTitle:@"没有更多数据了~" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.hidden = YES;
}

-(void)requestData {
    WeakSelf;
    completionBlock completionBlk = ^(JSONModel * _Nonnull model) {
        StrongSelf;
        if([model isKindOfClass:[LHShopListModel class]]) {
            LHShopListModel *listModel =(LHShopListModel *)model;
            self.tableView.mj_footer.hidden = NO;
            if(listModel.data.count) {
                [self.dataList addObjectsFromArray:listModel.data];
                [self.tableView reloadData];
            } else {
                self.isLastSuccess = NO;
                if(!self.dataList.count) {
                    self.tableView.mj_footer.hidden = YES;
                }
                [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
            }
        }
    };

    if(self.isLastSuccess) {
        switch (self.listType) {
            case LHShopListTypeCategory:
            {
                NSString *category = self.params[@"category"];
                [LHAPI requestShopListWithCatogory:category Page:self.pageNumber completion:completionBlk];
                break;
            }
            case LHShopListTypeSearch:
            {
                NSString *keyword = self.params[@"keyword"];
                NSString *category = self.params[@"category"];
                NSString *field = self.params[@"field"];
                [LHAPI requestShopListWithCategory:category field:field keyword:keyword page:self.pageNumber completion:completionBlk];

                break;
            }
            default:
                break;
        }
        self.pageNumber += 1;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHShopListDataModel *model = [self.dataList objectAtIndex:index];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LHShopListDataModel class]) forIndexPath:indexPath];
        if(cell == nil) {
            cell = [[LHShopListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([LHShopListDataModel class])];
        }
        if([cell isKindOfClass:[LHShopListItemCell class]]) {
            [(LHShopListItemCell *)cell refreshWithData:model];
        }
        return cell;
    }
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84 + 12 * 2 + 5;
}


@end
