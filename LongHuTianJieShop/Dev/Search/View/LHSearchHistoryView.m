//
//  LHSearchHistoryView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import "LHSearchHistoryView.h"
#import "UIViewAdditions.h"
#import "LHSearchHistoryFlowLayout.h"
#import "LHSeachItemCollectionCell.h"
#import "LHCommonDefine.h"
#import "NSString+LHExtention.h"
#import "UIFont+LHExtention.h"
#import "UIColor+LHExtention.h"

@interface LHSearchHistoryView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *deleteButton;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,copy) NSArray *dataList;
@property(nonatomic,assign) NSUInteger numberOfLine;
@property(nonatomic,assign) CGFloat viewHeight;
@end

@implementation LHSearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLine = 2;
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 18)];
    self.titleLabel.font =  [UIFont themeFontSemibold:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 15 - 20, 21, 20, 20)];
    [self.deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton setImage:[UIImage imageNamed:@"search_delete"] forState:UIControlStateNormal];
    [self.deleteButton setImage:[UIImage imageNamed:@"search_delete"] forState:UIControlStateHighlighted];
    self.deleteButton.hidden = YES;
    
    LHSearchHistoryFlowLayout *layout = [[LHSearchHistoryFlowLayout alloc] init];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.lineSpacing = 6;
    layout.numberOfLine = self.numberOfLine;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 10, self.width, 0) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[LHSeachItemCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([LHSeachItemCollectionCellModel class])];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.deleteButton];
    [self addSubview:self.collectionView];
}

- (void)updateTitle:(NSString *)title {
    self.titleLabel.text = title;
    self.titleLabel.width = [title widthWithFont:[UIFont themeFontSemibold:14] height:18];
}

-(void)setType:(LHSearchType)type {
    _type = type;
    _deleteButton.hidden = (type == LHSearchTypeRecommend);
}

-(void)refreshWithArray:(NSArray *)dataArray {
    CGFloat remainWidth = SCREEN_WIDTH - 30;
    NSInteger line = 1;
    self.dataList = dataArray;
    self.viewHeight = 15 + 18 + 10;
    
    for (LHSeachItemCollectionCellModel *model in dataArray) {
        CGFloat width = [LHSeachItemCollectionCell sizeForData:model].width;
        if (model == dataArray.firstObject) {
            width += 6;
            self.viewHeight += 34;
        }
        if (width <= remainWidth) {
            remainWidth -= width;
        } else {
            line++;
            if (line > self.numberOfLine) {
                break;
            }
            remainWidth = SCREEN_WIDTH - 30 - width;
            self.viewHeight += 40;
        }
    }
    self.height = self.viewHeight;
    self.collectionView.height = self.viewHeight - 18 - 15 - 10;
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)deleteAction {
    if(self.deleteBlock) {
        self.deleteBlock();
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    LHSeachItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LHSeachItemCollectionCellModel class]) forIndexPath:indexPath];
    if(index < self.dataList.count) {
        LHSeachItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        [cell refreshWithData:model];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHSeachItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        return [LHSeachItemCollectionCell sizeForData:model];
    }
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        LHSeachItemCollectionCellModel *model = [self.dataList objectAtIndex:index];
        if(self.selectBlock) {
            self.selectBlock(model);
        }
    }
}


@end
