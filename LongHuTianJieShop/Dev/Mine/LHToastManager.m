//
//  LHToastManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/14.
//

#import "LHToastManager.h"
#import "NSString+LHExtention.h"
#import "UIFont+LHExtention.h"
#import "LHWindowManager.h"
#import "UIViewAdditions.h"

@implementation LHToastManager
    
+ (instancetype)shareInstance {
    static LHToastManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHToastManager alloc] init];
    });
    return instance;
}

- (void)showToastWithText:(NSString *)text {
    [self showToastWithText:text time:2];
}
- (void)showToastWithText:(NSString *)text time:(NSTimeInterval)time {
    UIView *toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    toastView.backgroundColor = [UIColor blackColor];
    toastView.layer.cornerRadius = 4;
    toastView.layer.masksToBounds = YES;
    
    UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, 0, 18)];
    toastLabel.font = [UIFont themeFontRegular:14];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.text = text;
    toastLabel.width = [text widthWithFont:[UIFont themeFontRegular:14] height:18];
    toastView.width = toastLabel.width + 40;
    [toastView addSubview:toastLabel];
    toastView.center = [LHWindowManager shareInstance].window.center;
    
    toastView.alpha = 0;
    [[LHWindowManager shareInstance].window addSubview:toastView];
    [UIView animateWithDuration:0.2 animations:^{
        toastView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time animations:^{
            toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
        }];
    }];
}

@end
