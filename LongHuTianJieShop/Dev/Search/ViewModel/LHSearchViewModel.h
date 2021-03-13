//
//  LHSearchViewModel.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHSearchHistoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHSearchViewModel : NSObject <UITextFieldDelegate>
- (instancetype)initWithParams:(NSDictionary *)params histroyView:(LHSearchHistoryView *)histroyView recommandView:(LHSearchHistoryView *)recommandView;
- (void)updateView;
- (void)dumpHistoryData;
- (void)deleteHistoryData;
- (void)goToSearchResultWithText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
