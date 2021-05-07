//
//  LHShopDetailHeaderView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/6.
//

#import "LHShopDetailHeaderView.h"
#import <HMSegmentedControl.h>
#import "LHCommonDefine.h"
#import <SDWebImage.h>
#import "LHAPI.h"
#import "LHToastManager.h"
#import "LHShopDetailModel.h"
#import "LHAccoutManager.h"
#import "LHRoute.h"

@interface LHShopDetailHeaderMaskView : UIView

@end

@interface LHShopDetailHeaderView ()
@property(nonatomic,strong) UIImageView *backImageView;
@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *collectButton;
@property(nonatomic,strong) HMSegmentedControl *segmentedControl;
@property(nonatomic,copy) LHShopDetailModel *model;
@end

@implementation LHShopDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    
    self.backView = [[LHShopDetailHeaderMaskView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 92)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 12 * 2 - 60 - 10, 28)];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:self.titleLabel];
    
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
    self.segmentedControl.frame = CGRectMake(0, 53, SCREEN_WIDTH, 34);
    [self.backView addSubview:self.segmentedControl];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 60, 90, 60, 60)];
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor colorWithHexString:@"#f5f5f5"].CGColor;
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    
    self.collectButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 20, self.backView.height - 20 - 10, 20, 20)];
    [self.collectButton setImage:[UIImage imageNamed:@"collection_normal"] forState:UIControlStateNormal];
    [self.collectButton setImage:[UIImage imageNamed:@"collection_selected"] forState:UIControlStateSelected];
    [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.collectButton];

    [self addSubview:self.backImageView];
    [self addSubview:self.backView];
    [self addSubview:self.imageView];
}

- (void)refreshWithModel:(LHShopDetailModel *)model{
    self.model = model;
    self.titleLabel.text = self.model.data.name;
    NSURL *imageURL = [NSURL URLWithString:[self.model.data.picurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.backImageView sd_setImageWithURL:imageURL];
    [self.imageView sd_setImageWithURL:imageURL];
    self.collectButton.selected = self.model.data.collected;
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


@implementation LHShopDetailHeaderMaskView

-(void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:self.bounds
                              byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                              cornerRadii:CGSizeMake(10, 10)
                              ];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
