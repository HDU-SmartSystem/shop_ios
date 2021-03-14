//
//  LHShopListItemCell.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHShopListItemCell.h"
#import "UIViewAdditions.h"
#import "NSString+LHExtention.h"
#import "LHCommonDefine.h"
#import "LHShopListModel.h"
#import <SDWebImage/SDWebImage.h>
#import "UIColor+LHExtention.h"
#import "UIFont+LHExtention.h"

@interface LHShopListItemCell ()
@property(nonatomic,strong) UIImageView *shopImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *commentLabel;
@property(nonatomic,strong) UILabel *descLabel;
@property(nonatomic,strong) UIView *containerView;
@end

@implementation LHShopListItemCell

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

    self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 84, 84)];
    self.shopImageView.layer.cornerRadius = 4;
    self.shopImageView.layer.masksToBounds = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopImageView.right + 6, 12, SCREEN_WIDTH - 18 - 24 - 84 - 6, 24)];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopImageView.right + 6, self.titleLabel.bottom + 5, 0, 20)];
    self.commentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.commentLabel.textColor = [UIColor blackColor];

    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopImageView.right + 6, self.commentLabel.bottom + 5, 0, 20)];
    self.descLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.descLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.shopImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.commentLabel];
    [self.containerView addSubview:self.descLabel];
}

-(void)refreshWithData:(id)data {
    if(![data isKindOfClass:[LHShopListDataModel class]]) {
        return;
    }
    LHShopListDataModel *model = (LHShopListDataModel *)data;
    NSURL *imageUrl = [NSURL URLWithString:[model.picurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.shopImageView sd_setImageWithURL:imageUrl];
    
    self.titleLabel.text = model.name;
    CGFloat height = [model.name heightWithFont:[UIFont themeFontMedium:16] width:self.titleLabel.width];
    if(height > 24) {
        self.titleLabel.height = 40;
    } else {
        self.titleLabel.height = 24;
    }
    
    NSString *comment = [NSString stringWithFormat:@"%@条",model.commentNum];
    self.commentLabel.top = self.titleLabel.bottom + 5;
    self.commentLabel.text = comment;
    self.commentLabel.width = [comment widthWithFont:[UIFont themeFontRegular:14] height:20];
    
    self.descLabel.top = self.commentLabel.bottom + 5;
    self.descLabel.text = model.tag;
    self.descLabel.width = [model.tag widthWithFont:[UIFont themeFontRegular:14] height:20];
}


@end
