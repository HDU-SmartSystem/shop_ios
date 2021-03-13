//
//  LHLauchManger.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHLauchManger.h"
#import "LHSearchHistoryManager.h"

@implementation LHLauchManger

+ (instancetype)shareInstance {
    static LHLauchManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHLauchManger alloc] init];
    });
    return instance;
}


- (void)processAtBegin {
    [[LHSearchHistoryManager shareInstance] loadHistoryData];
}
@end
