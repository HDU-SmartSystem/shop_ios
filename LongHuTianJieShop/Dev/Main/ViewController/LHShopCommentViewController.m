//
//  LHShopCommentViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/8.
//

#import "LHShopCommentViewController.h"
#import <CDZStarsControl.h>
#import "LHCommonDefine.h"
#import "LHAccoutManager.h"
#import "LHToastManager.h"

@interface LHShopCommentItemView : UIView <CDZStarsControlDelegate>
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) CDZStarsControl *starControl;
@property(nonatomic,assign) CGFloat starScore;

@end

@interface LHShopCommentViewController () <UITextViewDelegate>
@property(nonatomic,strong) LHShopCommentItemView *totalItem;
@property(nonatomic,strong) LHShopCommentItemView *tasteItem;
@property(nonatomic,strong) LHShopCommentItemView *environmentItem;
@property(nonatomic,strong) LHShopCommentItemView *serviceItem;
@property(nonatomic,strong) UITextView *textInput;
@property(nonatomic,strong) UIButton *commitButton;
@property(nonatomic,copy) NSDictionary *params;
@end

@implementation LHShopCommentViewController

-(instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super initWithParams:params]) {
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.params[@"title"];
    self.totalItem = [[LHShopCommentItemView alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
    self.totalItem.titleLabel.text = @"总体";
    self.tasteItem = [[LHShopCommentItemView alloc] initWithFrame:CGRectMake(20, 140,300, 30)];
    self.tasteItem.titleLabel.text = @"口味";
    self.environmentItem = [[LHShopCommentItemView alloc] initWithFrame:CGRectMake(20, 180, 300, 30)];
    self.environmentItem.titleLabel.text = @"环境";
    self.serviceItem = [[LHShopCommentItemView alloc] initWithFrame:CGRectMake(20, 220, 300, 30)];
    self.serviceItem.titleLabel.text = @"服务";
    
    [self.view addSubview:self.totalItem];
    [self.view addSubview:self.tasteItem];
    [self.view addSubview:self.environmentItem];
    [self.view addSubview:self.serviceItem];
    
    self.textInput = [[UITextView alloc] initWithFrame:CGRectMake(20, self.serviceItem.bottom + 30, SCREEN_WIDTH - 40, 150)];
    self.textInput.backgroundColor = [UIColor whiteColor];
    self.textInput.delegate = self;
    self.textInput.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    self.textInput.text = @"请输入评论";
    self.textInput.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.view addSubview:self.textInput];
    
    self.commitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.textInput.bottom + 20, 100, 30)];
    self.commitButton.centerX = self.view.centerX;
    self.commitButton.layer.cornerRadius = 15;
    self.commitButton.layer.masksToBounds = YES;
    [self.commitButton setTitle:@"提交评论" forState:UIControlStateNormal];
    [self.commitButton setTitle:@"提交评论" forState:UIControlStateHighlighted];
    [self.commitButton setBackgroundColor:[UIColor colorWithHexString:@"#ff5500"]];
    [self.view addSubview:self.commitButton];
    [self.commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入评论";
        textView.textColor = [UIColor grayColor];
        textView.textColor = [UIColor colorWithHexString:@"#999999"];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入评论"]){
        textView.text=@"";
        textView.textColor=[UIColor colorWithHexString:@"#333333"];
    }
}

- (void)commitButtonClick {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = [LHAccoutManager shareInstance].user.userId;
    params[@"shopId"] = self.params[@"shopId"];
    params[@"text"] = self.textInput.text;
    params[@"allRate"] = @(self.totalItem.starScore);
    params[@"rate1"] = @(self.tasteItem.starScore);
    params[@"rate2"] = @(self.environmentItem.starScore);
    params[@"rate3"] = @(self.serviceItem.starScore);
    [LHAPI commitCommentWithParams:params completion:^(JSONModel * _Nonnull model) {
        if([model isKindOfClass:[LHUserModel class]]) {
            LHUserModel *resModel = (LHUserModel *)model;
            [[LHToastManager shareInstance] showToastWithText:resModel.message time:0.8];
            if([resModel.code integerValue] == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self goBack];
                });
            }
        }
    }];
}

@end


@implementation LHShopCommentItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView {
    self.userInteractionEnabled = YES;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    self.titleLabel.font = [UIFont themeFontRegular:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    self.starControl = [[CDZStarsControl alloc] initWithFrame:CGRectMake(50, 0,200, 30) stars:5 starSize:CGSizeMake(30, 30) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
    self.starControl.allowFraction = YES;
    self.starControl.delegate = self;
    [self addSubview:self.starControl];
}

-(void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score {
    self.starScore = score;
}

@end
