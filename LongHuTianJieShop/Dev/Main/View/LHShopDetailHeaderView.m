//
//  LHShopDetailHeaderView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/6.
//

#import "LHShopDetailHeaderView.h"
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
    
    self.backView = [[LHShopDetailHeaderMaskView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 48)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 12 * 2 - 60 - 10, 28)];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 60, 88, 60, 60)];
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor colorWithHexString:@"#f5f5f5"].CGColor;
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    

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
