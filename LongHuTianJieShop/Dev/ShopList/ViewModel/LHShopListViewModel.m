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
#import "LHShopListFilterView.h"
#import "LHShopListFilterView.h"
#import "LHWindowManager.h"
#import "LHRoute.h"
#import "LHAccoutManager.h"

@interface LHShopListViewModel () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) BOOL isLastSuccess;
@property(nonatomic,assign) LHShopListType listType;
@property(nonatomic,copy) NSDictionary* params;
@property(nonatomic,assign) NSInteger pageNumber;
@property(nonatomic,copy) NSArray *filterArray;
@property(nonatomic,strong) LHShopListFilterView *filterView;
@property(nonatomic,weak) LHShopListViewController *viewController;
@end

@implementation LHShopListViewModel

-(instancetype)initWithViewController:(LHShopListViewController *)viewController tableView:(UITableView *)tableView listType:(LHShopListType)type params:(NSDictionary *)params {
    if(self = [super init]){
        self.tableView = tableView;
        self.viewController = viewController;
        self.listType = type;
        self.params = params;
        self.pageNumber = 0;
        self.dataList = [NSMutableArray array];
        self.isLastSuccess = YES;
        [self configFilterView];
        [self configTableView];
        [self requestData];
    }
    return self;
}

-(void)configTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[LHShopListItemCell class] forCellReuseIdentifier:NSStringFromClass([LHShopListDataModel class])];
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

- (void)configFilterView {
    NSArray *filterArray = self.params[@"filter_data"];
    self.filterArray = filterArray;
    
    self.filterView = [[LHShopListFilterView alloc] initWithTableView:self.tableView viewController:self.viewController];
    self.filterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [self.filterView updateWithArray:self.filterArray];
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
            case LHShopListTypeCollection:
            {
                NSString *userId = [LHAccoutManager shareInstance].user.userId;
                [LHAPI requestCollectionWithUserId:userId Page:self.pageNumber completion:completionBlk];
            }
            case LHShopListTypeRecommand:
            {
                NSString *userId = [LHAccoutManager shareInstance].user.userId;
                [LHAPI requestRecommandWithUserId:userId Page:self.pageNumber completion:completionBlk];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0 && self.filterArray.count) {
        return self.filterView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 && self.filterArray.count) {
        return 44;
    }
    return CGFLOAT_MIN;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84 + 12 * 2 + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHShopListDataModel *model = [self.dataList objectAtIndex:index];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"title"] = model.name;
        params[@"image"] = model.picurl;
        params[@"shopId"] = model.id;
        [[LHRoute shareInstance] pushViewControllerWithURL:@"sslocal://shop_detail" params:params];
    }
}


@end
