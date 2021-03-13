//
//  LHSearchViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchViewController.h"
#import "LHSearchBarView.h"
#import "UIViewAdditions.h"
#import "LHSearchViewModel.h"
#import "LHCommonDefine.h"
#import "LHSearchHistoryView.h"
#import "LHSearchHistoryManager.h"

@interface LHSearchViewController ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,strong) LHSearchBarView *searchBar;
@property(nonatomic,strong) LHSearchViewModel *viewModel;
@property(nonatomic,strong) LHSearchHistoryView *historyView;
@property(nonatomic,strong) LHSearchHistoryView *recommandView;
@end

@implementation LHSearchViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]) {
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupViewModel];
}

- (void)setupView {
    NSString *title = self.params[@"title"];
    self.titleLabel.text = title;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[LHSearchBarView alloc] initWithFrame:CGRectMake(0, self.customNavBar.bottom,SCREEN_WIDTH, 44)];
    [self.searchBar.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBar];
    self.searchBar.textInput.text = self.params[@"keyword"];

    self.historyView = [[LHSearchHistoryView alloc] initWithFrame:CGRectMake(0, self.searchBar.bottom, SCREEN_WIDTH, 0)];
    self.historyView.type = LHSearchTypeHistory;
    [self.historyView updateTitle:@"搜索历史"];
    [self.view addSubview:self.historyView];
    
    
    self.recommandView = [[LHSearchHistoryView alloc] initWithFrame:CGRectMake(0, self.searchBar.bottom, SCREEN_WIDTH, 0)];
    self.recommandView.type = LHSearchTypeRecommend;
    [self.recommandView updateTitle:@"搜索发现"];
    [self.view addSubview:self.recommandView];
    
    self.historyView.deleteBlock = ^{
        [[LHSearchHistoryManager shareInstance] deleteHistoryData];
    };
    
    WeakSelf;
    self.historyView.selectBlock = ^(LHSeachItemCollectionCellModel * _Nonnull model) {
        StrongSelf;
        [self.viewModel goToSearchResultWithText:model.text];
    };
    
    self.recommandView.selectBlock = ^(LHSeachItemCollectionCellModel * _Nonnull model) {
        StrongSelf;
        [self.viewModel goToSearchResultWithText:model.text];
    };
}

- (void)setupViewModel {
    self.viewModel = [[LHSearchViewModel alloc] initWithParams:self.params histroyView:self.historyView recommandView:self.recommandView];
    self.searchBar.textInput.delegate = self.viewModel;
}


@end
