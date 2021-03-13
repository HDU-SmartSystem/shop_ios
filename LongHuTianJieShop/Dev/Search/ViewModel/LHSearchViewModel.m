//
//  LHSearchViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchViewModel.h"
#import "LHRoute.h"
#import "LHAPI.h"
#import "UIViewAdditions.h"
#import "LHCommonDefine.h"
#import "LHShopSearchRecommandModel.h"
#import "LHSeachItemCollectionCell.h"
#import "LHSearchHistoryManager.h"

@interface LHSearchViewModel ()
@property(nonatomic,copy) NSDictionary *params;
@property(nonatomic,weak) LHSearchHistoryView *historyView;
@property(nonatomic,weak) LHSearchHistoryView *recommandView;
@property(nonatomic,strong) NSMutableArray *recommandData;
@end

@implementation LHSearchViewModel

-(instancetype)initWithParams:(NSDictionary *)params histroyView:(LHSearchHistoryView *)histroyView recommandView:(LHSearchHistoryView *)recommandView {
    if(self = [super init]) {
        self.params = params;
        self.historyView = histroyView;
        self.recommandView = recommandView;
        self.recommandData = [NSMutableArray array];
        [self updateView];
        [self loadRecommandData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:kLHSearchHistoryChangedNotification object:nil];
    }
    return self;
}

- (void)updateView {
    NSArray *historyArray = [LHSearchHistoryManager shareInstance].historyData;
    NSMutableArray *historyModelArray = [NSMutableArray array];
    for(NSString *text in historyArray) {
        LHSeachItemCollectionCellModel *model = [[LHSeachItemCollectionCellModel alloc] init];
        model.text = text;
        [historyModelArray addObject:model];
    }
    [self.historyView refreshWithArray:historyModelArray];
    self.recommandView.top = self.historyView.bottom;
}

- (void)loadRecommandData {
    WeakSelf;
    [LHAPI requestSearchRecommandWithcompletion:^(JSONModel * _Nonnull model) {
        StrongSelf;
        if([model isKindOfClass:[LHShopSearchRecommandModel class]]) {
            LHShopSearchRecommandModel *recommandModel = (LHShopSearchRecommandModel *)model;
            for(NSString *text in recommandModel.data) {
                if(text.length) {
                    LHSeachItemCollectionCellModel *model = [[LHSeachItemCollectionCellModel alloc] init];
                    model.text = text;
                    [self.recommandData addObject:model];
                }
            }
            [self.recommandView refreshWithArray:self.recommandData];
        }
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = textField.text;
    [self goToSearchResultWithText:text];
    return YES;
}

- (void)goToSearchResultWithText:(NSString *)text {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category"] = self.params[@"category"];
    params[@"field"] = @"name";
    params[@"keyword"] = text;
    [[LHRoute shareInstance] pushViewControllerWithURL:@"sslocal://search_result" params:params];
    [[LHSearchHistoryManager shareInstance] addHistoryText:text];
}

@end
