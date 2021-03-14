//
//  LHShopListFilterListView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHShopListFilterListView.h"
#import "UIColor+LHExtention.h"
#import "LHCommonDefine.h"
#import "UIViewAdditions.h"
#import "UIFont+LHExtention.h"

@interface LHShopListFilterListView () <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *dataList;
@property(nonatomic,strong) UIView *backView;
@end

@implementation LHShopListFilterListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.layer.masksToBounds = YES;
    self.backView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.4];
    [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithModel:)]];
    [self addSubview:self.backView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,0)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[LHShopListFilterListItemCell class] forCellReuseIdentifier:NSStringFromClass([LHShopListFilterListItemModel class])];
    [self addSubview:self.tableView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self addSubview:lineView];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.backView.frame = CGRectMake(0, 0,self.width, self.height);
}

-(void)updateWithArray:(NSArray *)itemArray {
    if(self.dataList == itemArray) {
        [self hiddenWithModel:nil];
        return;
    }
    self.dataList = itemArray;
    [self.tableView reloadData];
    self.tableView.height = 44 * self.dataList.count;
    if(self.hidden) {
        self.hidden = NO;
        self.tableView.top = - self.tableView.height;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.top = 0;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)hiddenWithModel:(LHShopListFilterListItemModel *)model {
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.top = - self.tableView.height;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.dataList = nil;
        if(self.clickItemBlock && [model isKindOfClass:[LHShopListFilterListItemModel class]]) {
            self.clickItemBlock(model);
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHShopListFilterListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LHShopListFilterListItemModel class]) forIndexPath:indexPath];
    if(!cell) {
        cell = [[LHShopListFilterListItemCell alloc] init];
    }
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        [cell refreshWithData:[self.dataList objectAtIndex:index]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if(index < self.dataList.count) {
        [self hiddenWithModel:[self.dataList objectAtIndex:index]];
    }
}

@end


@implementation LHShopListFilterListItemModel
@end

@interface LHShopListFilterListItemCell ()
@property(nonatomic,strong) UILabel *label;
@end
@implementation LHShopListFilterListItemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 24)];
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont themeFontMedium:14];
    self.label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.label];
}

-(void)refreshWithData:(id)data {
    if([data isKindOfClass:[LHShopListFilterListItemModel class]]) {
        LHShopListFilterListItemModel *model = (LHShopListFilterListItemModel *)data;
        self.label.text = model.itemName;
    }
}

@end
