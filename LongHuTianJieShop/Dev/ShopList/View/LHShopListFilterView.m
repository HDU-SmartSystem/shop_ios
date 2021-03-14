//
//  LHShopListFilterView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHShopListFilterView.h"
#import "LHCommonDefine.h"
#import "UIFont+LHExtention.h"
#import "UIViewAdditions.h"
#import "UIColor+LHExtention.h"
#import "NSString+LHExtention.h"
#import "LHShopListFilterListView.h"

@interface LHShopListFilterView () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,copy) NSArray *dataList;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,weak) UIViewController *viewController;
@property(nonatomic,strong) LHShopListFilterListView *filterListView;
@property(nonatomic,strong) LHShopListFilterItemModel *selectedModel;
@property(nonatomic,strong) NSMutableDictionary *params;
@end

@implementation LHShopListFilterView

- (instancetype)initWithTableView:(UITableView *)tableView viewController:(UIViewController *)viewController {
    if(self = [super init]) {
        self.tableView = tableView;
        self.viewController = viewController;
        self.params = [NSMutableDictionary dictionary];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[LHShopListFilterItemCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([LHShopListFilterItemModel class])];
    [self addSubview:self.collectionView];
    
    self.filterListView = [[LHShopListFilterListView alloc] initWithFrame:CGRectZero];
    self.filterListView.hidden = YES;
    [self.viewController.view addSubview:self.filterListView];
    WeakSelf;
    self.filterListView.clickItemBlock = ^(LHShopListFilterListItemModel * _Nonnull model) {
        StrongSelf;
        if(self.selectedModel.filterCategory.length && model.itemValue.length) {
            self.params[self.selectedModel.filterCategory] = model.itemValue;
        }
        if(model.itemName.length) {
            self.selectedModel.name = model.itemName;
            [self.collectionView reloadData];
        }
    };
}

-(void)updateWithArray:(NSArray *)itemArray {
    self.dataList = itemArray;
    [self.collectionView reloadData];
}

- (void)clickFilterItem:(LHShopListFilterItemModel *)model {
    self.selectedModel = model;
    CGPoint filterPoint = self.frame.origin;
    [self.tableView setContentOffset:filterPoint animated:NO];
    CGRect filterViewFrame = [self.viewController.view convertRect:self.frame fromView:self.tableView];
    self.filterListView.frame = CGRectMake(0, filterViewFrame.origin.y + filterViewFrame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.viewController.view.top - filterViewFrame.size.height);
    [self.filterListView updateWithArray:model.items];
}

- (CGFloat)itemWidth {
    if(self.dataList.count) {
        return ceil(SCREEN_WIDTH / (self.dataList.count * 1.0f));
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    LHShopListFilterItemCollectionCell *cell =(LHShopListFilterItemCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LHShopListFilterItemModel class]) forIndexPath:indexPath];
    if(index < self.dataList.count) {
        LHShopListFilterItemModel *model = [self.dataList objectAtIndex:index];
        if([cell isKindOfClass:[LHShopListFilterItemCollectionCell class]] && [model isKindOfClass:[LHShopListFilterItemModel class]]) {
            [cell refreshWithData:model];
        }
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self itemWidth], 44);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        [self clickFilterItem:[self.dataList objectAtIndex:index]];
    }
}

@end


@implementation LHShopListFilterItemModel

@end


@interface LHShopListFilterItemCollectionCell ()
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UIImageView *iconView;
@end

@implementation LHShopListFilterItemCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 0, 20)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont themeFontMedium:16];
    [self.contentView addSubview:self.nameLabel];
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-triangle"] highlightedImage:[UIImage imageNamed:@"icon-triangle"]];
    [self.contentView addSubview:self.iconView];
}

- (void)refreshWithData:(id)data {
    if([data isKindOfClass:[LHShopListFilterItemModel class]]) {
        LHShopListFilterItemModel *model = (LHShopListFilterItemModel *)data;
        self.nameLabel.text = model.name;
        self.nameLabel.width = [model.name widthWithFont:[UIFont themeFontMedium:16] height:20];
        self.nameLabel.center = self.contentView.center;
        self.iconView.frame = CGRectMake(0, 0, 12, 12);
        self.iconView.centerY = self.contentView.centerY;
        self.iconView.left = self.nameLabel.right + 2;
    }
}

@end
