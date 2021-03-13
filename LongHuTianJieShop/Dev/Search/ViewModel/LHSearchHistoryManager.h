//
//  LHSearchHistoryManager.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *kLHSearchHistoryChangedNotification = @"kLHSearchHistoryChangedNotification";
@interface LHSearchHistoryManager : NSObject
@property(nonatomic,strong) NSMutableArray *historyData;
+ (instancetype)shareInstance;
- (void)loadHistoryData;
- (void)deleteHistoryData;
- (void)addHistoryText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
