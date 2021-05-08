//
//  LHShopDetailSubViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/8.
//

#import "LHShopDetailSubViewModel.h"
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

@interface LHShopDetailSubViewModel () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) BOOL isLastSuccess;
@property(nonatomic,assign) LHShopDetailSubType listType;
@property(nonatomic,copy) NSDictionary* params;
@property(nonatomic,assign) NSInteger pageNumber;
@property(nonatomic,weak) LHShopDetailSubViewController *viewController;
@property(nonatomic,weak) LHHorizontalPagingView *paginView;
@end

@implementation LHShopDetailSubViewModel

-(instancetype)initWithViewController:(LHShopDetailSubViewController *)viewController tableView:(UITableView *)tableView listType:(LHShopDetailSubType)type params:(NSDictionary *)params {
    if(self = [super init]){
        self.tableView = tableView;
        self.viewController = viewController;
        self.listType = type;
        self.params = params;
        self.pageNumber = 0;
        self.dataList = [NSMutableArray array];
        self.isLastSuccess = YES;
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
            case LHShopDetailSubGoods:
            {
                NSString *shopId = self.params[@"shopId"];
                [LHAPI requestCommentWithShopId:shopId userId:@"1" completion:completionBlk];
                break;
            }
            case LHShopDetailSubComments:
            {
                NSString *shopId = self.params[@"shopId"];
                [LHAPI requestCommentWithShopId:shopId userId:@"1" completion:completionBlk];
                break;
            }
            default:
                break;
        }
        self.pageNumber += 1;
    }
}

-(void)updatePagingView:(LHHorizontalPagingView *)pagingView {
    self.paginView = pagingView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
    return self.dataList.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    if(index < self.dataList.count) {
        return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    cell.backgroundColor = [self randomColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.paginView tableViewDidScroll:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.paginView tableViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.paginView tableViewDidEndDragging:scrollView];
}

- (UIColor*) randomColor{
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}


@end

