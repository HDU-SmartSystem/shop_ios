//
//  LHSearchHistoryManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHSearchHistoryManager.h"
#import <UIKit/UIApplication.h>


@interface LHSearchHistoryManager ()
@property(nonatomic,strong) NSMutableSet *historySet;
@end

@implementation LHSearchHistoryManager

+ (instancetype)shareInstance {
    static LHSearchHistoryManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHSearchHistoryManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historySet = [NSMutableSet set];
        self.historyData = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)loadHistoryData {
    NSArray *historyData = [[NSUserDefaults standardUserDefaults] objectForKey:@"search_history"];
    for(NSString *text in historyData) {
        [self.historyData addObject:text];
        [self.historySet addObject:text];
    }
}

- (void)dumpHistoryData {
    [[NSUserDefaults standardUserDefaults] setValue:self.historyData forKey:@"search_history"];
}

- (void)deleteHistoryData {
    [self.historySet removeAllObjects];
    [self.historyData removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLHSearchHistoryChangedNotification object:nil];
}

- (void)addHistoryText:(NSString *)text {
    if(![self.historySet containsObject:text]) {
        [self.historyData addObject:text];
        [self.historySet addObject:text];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLHSearchHistoryChangedNotification object:nil];
    }
}

- (void)applicationWillTerminate {
    [self dumpHistoryData];
}

@end
