//
//  LHSearchResultViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchResultViewController.h"
#import "LHShopListViewController.h"
#import "UIViewAdditions.h"
#import "LHCommonDefine.h"
#import "LHWindowManager.h"
#import "UIColor+LHExtention.h"
#import "UIFont+LHExtention.h"

@interface LHSearchResultViewController ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,strong) LHShopListViewController *shopListVC;
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UIButton *mapButton;
@end

@implementation LHSearchResultViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]) {
        self.params = params;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.shopListVC = [[LHShopListViewController alloc] initWithListType:LHShopListTypeSearch params:self.params];
    [self.view addSubview:self.shopListVC.view];
    [self.shopListVC updateFrame:CGRectMake(0, self.customNavBar.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height - [[LHWindowManager shareInstance] window].safeAreaInsets.bottom)];
    
    [self.customNavBar addSubview:self.searchView];
    [self.customNavBar addSubview:self.mapButton];
}

-(UIView *)searchView {
    if(!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(15 + 24 + 15, self.customNavBar.bottom - 44 + 5, SCREEN_WIDTH - 24 * 2 - 15 * 4 , 34)];;
        _searchView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        _searchView.layer.borderColor = [UIColor colorWithHexString:@"#e8e8e8"].CGColor;
        _searchView.layer.borderWidth = 0.5;
        _searchView.layer.cornerRadius = self.searchView.height / 2.f;

        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 16, 16)];
        searchIcon.image = [UIImage imageNamed:@"search_icon"];
        [_searchView addSubview:searchIcon];
        
        UITextField *textInput = [[UITextField alloc] initWithFrame:CGRectMake(30, 7, self.searchView.width - 30, 20)];
        textInput.background = NULL;
        textInput.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        textInput.userInteractionEnabled = NO;
        NSString *placeHolderString = self.params[@"keyword"];
        if(placeHolderString.length) {
            NSDictionary *attrDict = @{
                NSFontAttributeName:[UIFont themeFontRegular:14],
                NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
            };
            NSAttributedString *attrPlaceHolder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:attrDict];
            textInput.attributedPlaceholder = attrPlaceHolder;
        }

        [_searchView addSubview:textInput];
        [_searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToSearch)]];
    }
    return _searchView;
}

- (UIButton *)mapButton {
    if(!_mapButton) {
        _mapButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 24 - 15, self.customNavBar.bottom - 24 - 10, 24, 24)];
        [_mapButton setImage:[UIImage imageNamed:@"map_icon"] forState:UIControlStateNormal];
        [_mapButton setImage:[UIImage imageNamed:@"map_icon"] forState:UIControlStateHighlighted];
    }
    return _mapButton;
}

- (void)jumpToSearch {
    NSString *openURL = @"sslocal://search";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"title"] = @"龙湖天街";
    params[@"keyword"] = self.params[@"keyword"];
    [[LHRoute shareInstance] pushViewControllerWithURL:openURL params:params];
}

@end
