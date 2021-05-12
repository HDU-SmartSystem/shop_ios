//
//  LHShopCommentCell.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/12.
//

#import "LHShopCommentCell.h"
#import "LHCommonDefine.h"
#import "LHShopCommentModel.h"
#import "NSString+LHExtention.h"

@interface LHShopCommentCell ()
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *descLabel;
@property(nonatomic,strong) UIView *containerView;
@end

@implementation LHShopCommentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(9 ,5, SCREEN_WIDTH - 18, 0)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.layer.masksToBounds = YES;

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 50, 24)];
    self.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor blackColor];
    

    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.titleLabel.bottom + 5,SCREEN_WIDTH - 12 * 2 - 9 * 2 , 0)];
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [UIFont themeFontRegular:14];
    self.descLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.descLabel];
}

-(void)refreshWithData:(id)data {
    if(![data isKindOfClass:[LHShopCommentDataModel class]]) {
        return;
    }
    LHShopCommentDataModel *model = (LHShopCommentDataModel *)data;
    
    self.titleLabel.text = [model.allRate stringByAppendingString:@"分"];

    self.descLabel.top = self.titleLabel.bottom + 5;
    self.descLabel.text = model.text;
    self.descLabel.height = [self.descLabel.text heightWithFont:[UIFont themeFontRegular:14] width:SCREEN_WIDTH - 12 * 2 - 9 * 2];
    self.containerView.height = self.descLabel.height + 46 - 5;
}

@end
