//
//  LHShopDetailViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/6.
//

#import "LHAPI.h"
#import "LHShopDetailViewController.h"
#import "LHShopDetailHeaderView.h"
#import "LHCommonDefine.h"
#import "LHShopDetailModel.h"
#import "LHAccoutManager.h"
#import "LHShopDetailSubViewController.h"
#import <HMSegmentedControl.h>
#import "LHToastManager.h"
#import "LHHorizontalPagingView.h"
#import "LHWindowManager.h"

@interface LHShopDetailViewController () <LHHorizontalPagingViewDelegate>
@property(nonatomic,strong) NSDictionary *params;
@property(nonatomic,strong) LHShopDetailHeaderView *headerView;
@property(nonatomic,strong) LHShopDetailModel *model;
@property(nonatomic,strong) NSArray *detailVCList;
@property(nonatomic,strong) LHHorizontalPagingView *pagingView;
@property(nonatomic,strong) HMSegmentedControl *segmentedControl;
@property(nonatomic,strong) UIButton *collectButton;
@property(nonatomic,strong) UIButton *commentButton;
@property(nonatomic,strong) UIView *segmentView;
@property(nonatomic,strong) UIView *navBackView;
@end


@implementation LHShopDetailViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]){
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [[LHShopDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148)];
    self.navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.customNavBar.height)];
    self.navBackView.backgroundColor = [UIColor whiteColor];
    self.pagingView = [[LHHorizontalPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pagingView.delegate = self;
    [self.view addSubview:self.pagingView];
    [self.customNavBar addSubview:self.navBackView];

    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"商品",@"评价",@"商家"]];
    self.segmentedControl.type = HMSegmentedControlTypeText;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationBottom;
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont themeFontRegular:16],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]};
    self.segmentedControl.titleTextAttributes = titleTextAttributes;

    NSDictionary *selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont themeFontMedium:18],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]};
    self.segmentedControl.selectedTitleTextAttributes = selectedTitleTextAttributes;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithHexString:@"#ff9629"];
//    self.segmentedControl.selectionIndicatorWidth = 20.0f;
    self.segmentedControl.selectionIndicatorHeight = 4.0f;
//    self.segmentedControl.selectionIndicatorCornerRadius = 2.0f;
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(5, 14, 0, 14);
    self.segmentedControl.frame = CGRectMake(0, 10, SCREEN_WIDTH, 34);
    
    self.collectButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 20, 12, 20, 20)];
    [self.collectButton setImage:[UIImage imageNamed:@"collection_normal"] forState:UIControlStateNormal];
    [self.collectButton setImage:[UIImage imageNamed:@"collection_selected"] forState:UIControlStateSelected];
    [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(self.collectButton.left - 40 - 10, 13, 40, 24)];
    [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [self.commentButton setTitle:@"评论" forState:UIControlStateHighlighted];
    [self.commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.commentButton.titleLabel.font = [UIFont themeFontRegular:16];
    [self.commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];

    if([[LHAccoutManager shareInstance] isLogin]) {
        WeakSelf;
        [LHAPI reqeustShopDetailWithShopId:self.params[@"shopId"] userId:[LHAccoutManager shareInstance].user.userId completion:^(JSONModel * _Nonnull model) {
            if([model isKindOfClass:[LHShopDetailModel class]]) {
                StrongSelf;
                self.model = (LHShopDetailModel *)model;
                self.model.data.picurl = [[LHAPI host] stringByAppendingFormat:@"/images/%@",self.model.data.picurl];
                self.collectButton.selected = self.model.data.collected;
                [self.headerView refreshWithModel:self.model];
            }
        }];
    } else {
        self.model = [[LHShopDetailModel alloc] init];
        self.model.data = [[LHShopDetailDataModel alloc] init];
        self.model.data.picurl = self.params[@"image"];
        self.model.data.name = self.params[@"title"];
        self.model.data.collected = NO;
        [self.headerView refreshWithModel:self.model];
    }
    
    LHShopDetailSubViewController *goodVC = [[LHShopDetailSubViewController alloc] initWithListType:LHShopDetailSubGoods params:self.params];
    LHShopDetailSubViewController *commentVC = [[LHShopDetailSubViewController alloc] initWithListType:LHShopDetailSubComments params:self.params];
    self.detailVCList = @[goodVC,commentVC];
    

    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, SCREEN_WIDTH, 44)];
    [self.segmentView addSubview:self.segmentedControl];
    [self.segmentView addSubview:self.collectButton];
    [self.segmentView addSubview:self.commentButton];
    
    for(LHShopDetailSubViewController *vc in self.detailVCList){
        [vc view];
        [vc updatePagingView:self.pagingView];
    }
    NSArray *tableViewArray = @[goodVC.tableView,commentVC.tableView];
    
    [self.pagingView updateWithHeaderView:self.headerView segmentedView:self.segmentView navBar:self.customNavBar tableViewArray:tableViewArray];
    WeakSelf;
    self.segmentedControl.indexChangeBlock = ^(NSUInteger index) {
        StrongSelf;
        [self.pagingView updateSelectIndex:index];
    };

    self.customNavBar.backgroundColor = [UIColor clearColor];
    self.navBackView.alpha = 0;
    [self.view bringSubviewToFront:self.customNavBar];
    for(UIView *subView in self.customNavBar.subviews) {
        if(subView != self.navBackView) {
            [self.customNavBar bringSubviewToFront:subView];
        }
    }
}

-(void)contentViewDidScroll:(CGFloat)offset {
    self.navBackView.alpha = offset/ (self.pagingView.moveView.height - self.customNavBar.height - self.segmentView.height);
}

-(void)scrollToIndex:(NSInteger)index {
    self.segmentedControl.selectedSegmentIndex = index;
}

- (void)commentButtonClick {
    if([[LHAccoutManager shareInstance] isLogin]) {
        [[LHRoute shareInstance] pushViewControllerWithURL:@"sslocal://comment" params:self.params];
    } else {
        [[LHRoute shareInstance] presentViewControllerWithURL:@"sslocal://login" params:nil];
    }
}

- (void)collectButtonClick {
    if([[LHAccoutManager shareInstance] isLogin]) {
        [LHAPI addColletionWithShopId:self.model.data.id userId:[LHAccoutManager shareInstance].user.userId completion:nil];
        self.collectButton.selected = !self.collectButton.selected;
        if(self.collectButton.selected) {
            [[LHToastManager shareInstance] showToastWithText:@"收藏成功" time:1];
        } else {
            [[LHToastManager shareInstance] showToastWithText:@"取消收藏" time:1];
        }
    } else {
        [[LHRoute shareInstance] presentViewControllerWithURL:@"sslocal://login" params:nil];
    }
}



@end
