//
//  LHShopGoodCell.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/12.
//

#import "LHShopGoodCell.h"
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"
#import "LHCommonDefine.h"
#import "LHShopListModel.h"
#import <SDWebImage/SDWebImage.h>
#import "UIColor+LHExtention.h"
#import "UIFont+LHExtention.h"
#import "LHShopGoodModel.h"

@interface LHShopGoodCell ()
@property(nonatomic,strong) UIImageView *goodImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *descLabel;
@property(nonatomic,strong) UIView *containerView;
@end

@implementation LHShopGoodCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(9 ,5, SCREEN_WIDTH - 18, 84 + 12 * 2)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.layer.masksToBounds = YES;

    self.goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 84, 84)];
    self.goodImageView.layer.cornerRadius = 4;
    self.goodImageView.layer.masksToBounds = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImageView.right + 6, 12, SCREEN_WIDTH - 18 - 24 - 84 - 6, 24)];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    

    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImageView.right + 6, self.titleLabel.bottom + 5, 0, 20)];
    self.descLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.descLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.goodImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.descLabel];
}

-(void)refreshWithData:(id)data {
    if(![data isKindOfClass:[LHShopGoodDataModel class]]) {
        return;
    }
    LHShopGoodDataModel *model = (LHShopGoodDataModel *)data;
    NSURL *imageUrl = [NSURL URLWithString:[model.picurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.goodImageView sd_setImageWithURL:imageUrl];
    
    self.titleLabel.text = model.name;
    CGFloat height = [model.name heightWithFont:[UIFont themeFontMedium:16] width:self.titleLabel.width];
    if(height > 24) {
        self.titleLabel.height = 40;
    } else {
        self.titleLabel.height = 24;
    }
    
    self.descLabel.top = self.titleLabel.bottom + 5;
    self.descLabel.text = [model.price stringByAppendingString:@"元"];
    self.descLabel.width = [self.descLabel.text widthWithFont:[UIFont themeFontRegular:14] height:20];
}

@end
