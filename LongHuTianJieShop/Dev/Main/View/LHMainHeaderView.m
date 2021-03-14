//
//  LHMainHeaderView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHMainHeaderView.h"
#import "UIViewAdditions.h"
#import "LHCommonDefine.h"
#import "UIFont+LHExtention.h"
#import "UIColor+LHExtention.h"
#import "LHRoute.h"

@interface LHMainHeaderView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,copy) NSArray *dataList;
@end

@implementation LHMainHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupDataList];
    }
    return self;
}


- (void)setupView {
    LHHeaderCollectionViewFlowLayout *layout = [[LHHeaderCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.numberOfLine = 2;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 9, self.width - 24, self.height - 18) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.layer.cornerRadius = 10;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LHHeaderItemCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([LHHeaderItemCollectionCellModel class])];
    
    [self addSubview:self.collectionView];
}


- (void)setupDataList {
    NSMutableArray *dataList = [NSMutableArray array];
    
    NSArray *imageArray = @[
        @"special_price",
        @"delicious_food",
        @"make_up",
        @"jewellery",
        @"furniture",
        @"amusement",
        @"digital",
        @"parenting",
        @"education",
        @"supermarket",
    ];
    
    NSArray *nameArray = @[
        @"精品特价",
        @"餐饮美食",
        @"美妆丽人",
        @"珠宝配饰",
        @"生活家居",
        @"休闲娱乐",
        @"数码家电",
        @"母婴亲子",
        @"教育文化",
        @"超市综合",
    ];
    
    NSArray *categoryArray = @[
        @"special",
        @"restaurant",
        @"beauty",
        @"null",
        @"life",
        @"amusement",
        @"null",
        @"child",
        @"education",
        @"null",
    ];
    
    
    for(NSInteger i = 0; i < imageArray.count; i++) {
        LHHeaderItemCollectionCellModel *model = [[LHHeaderItemCollectionCellModel alloc] init];
        model.imageName = [imageArray objectAtIndex:i];
        model.text = [nameArray objectAtIndex:i];
        model.category = [categoryArray objectAtIndex:i];
        [dataList addObject:model];
    }
    self.dataList = dataList;
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    LHHeaderItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LHHeaderItemCollectionCellModel class]) forIndexPath:indexPath];
    if(index < self.dataList.count) {
        LHHeaderItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        [cell refreshWithData:model];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHHeaderItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        return [LHHeaderItemCollectionCell sizeForData:model];
    }
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHHeaderItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"title"] = model.text;
        param[@"category"] = model.category;
        [[LHRoute shareInstance] pushViewControllerWithURL:@"sslocal://category_list" params:param];
    }
}

@end


@implementation LHHeaderCollectionViewFlowLayout
-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
    if(!attr.count) {
        return attr;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:attr.firstObject];
    NSUInteger numberOfLine = 1;
    for(NSUInteger i = 1; i < attr.count; i++) {
        UICollectionViewLayoutAttributes *curAttr = [attr objectAtIndex:i];
        UICollectionViewLayoutAttributes *preAttr = [attr objectAtIndex:i - 1];
        CGFloat left = CGRectGetMaxX(preAttr.frame);
        if(CGRectGetMinX(curAttr.frame) >= left) {
            CGRect frame = curAttr.frame;
            frame.origin.x = left;
            curAttr.frame = frame;
        } else {
            numberOfLine++;
            if(numberOfLine > self.numberOfLine) {
                break;
            }
        }
        [array addObject:curAttr];
    }
    return array;
}
@end


@implementation LHHeaderItemCollectionCellModel
@end

@interface LHHeaderItemCollectionCell ()
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *iconLabel;
@end

@implementation LHHeaderItemCollectionCell

+(CGSize)sizeForData:(id)data {
    CGFloat witdh = floor((SCREEN_WIDTH - 24) / 5.0f);
    return CGSizeMake(witdh, 80);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    CGFloat witdh = ceil((SCREEN_WIDTH - 24) / 5.0f);
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 48, 48)];
    self.iconView.centerX = witdh / 2.0f;
    self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, witdh, 20)];
    self.iconLabel.font = [UIFont themeFontRegular:12];
    self.iconLabel.textAlignment = NSTextAlignmentCenter;
    self.iconLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.iconLabel];
}

- (void)refreshWithData:(id)data {
    if([data isKindOfClass:[LHHeaderItemCollectionCellModel class]]) {
        LHHeaderItemCollectionCellModel *model = (LHHeaderItemCollectionCellModel *)data;
        self.iconView.image = [UIImage imageNamed:model.imageName];
        self.iconLabel.text = model.text;
    }
}

@end
