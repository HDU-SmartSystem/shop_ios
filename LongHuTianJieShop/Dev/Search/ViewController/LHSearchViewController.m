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

@interface LHSearchViewController ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,strong) LHSearchBarView *searchBar;
@property(nonatomic,strong) LHSearchViewModel *viewModel;
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
    
}

- (void)setupViewModel {
    self.viewModel = [[LHSearchViewModel alloc] init];
    self.searchBar.textInput.delegate = self.viewModel;
}

@end
