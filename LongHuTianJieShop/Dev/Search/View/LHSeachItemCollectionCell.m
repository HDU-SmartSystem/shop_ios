//
//  LHSeachItemCollectionCell.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import "LHSeachItemCollectionCell.h"
#import "NSString+LHExtention.h"
#import "UIFont+LHExtention.h"
#import "UIColor+LHExtention.h"
#import "UIViewAdditions.h"
@interface LHSeachItemCollectionCell ()
@property(nonatomic,strong) UILabel *label;
@end


@implementation LHSeachItemCollectionCell
+ (CGSize)sizeForData:(id)data {
    if([data isKindOfClass:[LHSeachItemCollectionCellModel class]]) {
        LHSeachItemCollectionCellModel *model = (LHSeachItemCollectionCellModel *)data;
        CGFloat width = [model.text widthWithFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] height:16];
        return CGSizeMake(width + 18, 34);
    }
    return CGSizeZero;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(9, 9, 0, 16)];
    self.label.font = [UIFont themeFontRegular:12];
    self.label.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:self.label];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.masksToBounds = YES;
}

- (void)refreshWithData:(id)data {
    if([data isKindOfClass:[LHSeachItemCollectionCellModel class]]) {
        LHSeachItemCollectionCellModel *model = (LHSeachItemCollectionCellModel *)data;
        CGFloat width = [model.text widthWithFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] height:16];
        self.label.text = model.text;
        self.label.width = width;
    }
}
@end

@implementation LHSeachItemCollectionCellModel
@end
