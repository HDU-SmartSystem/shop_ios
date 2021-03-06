//
//  LHMainTopView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHMainTopView.h"
#import "NSString+LHExtention.h"
#import "UIViewAdditions.h"
#import "UIColor+LHExtention.h"
#import "LHCommonDefine.h"
#import "LHRoute.h"

@interface LHMainTopView ()
@property(nonatomic,strong) UILabel *shopNameLabel;
@property(nonatomic,strong) UIImageView *searchImageView;
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UIImageView *scanView;
@end

@implementation LHMainTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.shopNameLabel = [[UILabel alloc] init];
    self.shopNameLabel.font = [UIFont systemFontOfSize:14];
    self.shopNameLabel.textColor = [UIColor blackColor];
    NSString *name = @"龙湖天街";
    CGFloat nameWith = [name widthWithFont:[UIFont systemFontOfSize:14] height:20];
    self.shopNameLabel.frame = CGRectMake(10, self.bottom - 10 - 20, nameWith, 20);
    self.shopNameLabel.text = name;

    self.scanView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 20, self.bottom - 10 - 20, 20, 20)];
    self.scanView.image = [UIImage imageNamed:@"binary_scan"];
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(self.shopNameLabel.right + 10, self.bottom - 5 - 30,self.scanView.left - self.shopNameLabel.right - 25 , 30)];
    self.searchView.layer.cornerRadius = self.searchView.height / 2.f;
    self.searchView.backgroundColor = [UIColor whiteColor];
    [self.searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToSearch)]];
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.searchView.width - 5 - 20, 5, 20, 20)];
    self.searchImageView.image = [UIImage imageNamed:@"main_search_icon"];

    [self addSubview:self.shopNameLabel];
    [self addSubview:self.scanView];
    [self addSubview:self.searchView];
    [self.searchView addSubview:self.searchImageView];
}

- (void)jumpToSearch {
    NSString *openURL = @"sslocal://search";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"title"] = @"龙湖天街";
    [[LHRoute shareInstance] pushViewControllerWithURL:openURL params:params];
}

@end
