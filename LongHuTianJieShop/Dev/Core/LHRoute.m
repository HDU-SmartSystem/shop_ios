//
//  LHRoute.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHRoute.h"
#import "LHWindowManager.h"

@implementation LHRoute

+ (instancetype)shareInstance {
    static LHRoute *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHRoute alloc] init];
    });
    return instance;
}

- (void)pushViewControllerWithURL:(NSString *)url params:(nullable NSDictionary *)params {
    //sslocal://main
    NSRange range = [url rangeOfString:@"://"];
    if(range.location != NSNotFound) {
        NSString *schema = [url substringFromIndex:NSMaxRange(range)];
        NSString *className = [self classNameWithURL:schema];
        if(className) {
            Class classInstance = NSClassFromString(className);
            if([classInstance conformsToProtocol:@protocol(LHRouteProtocol)]) {
                UIViewController *vc = [[classInstance alloc] initWithParams:params];
                vc.hidesBottomBarWhenPushed = YES;
                [[[LHWindowManager shareInstance] currentNavigationController] pushViewController:vc animated:YES];
            }
        }
    }
}

- (void)presentViewControllerWithURL:(NSString *)url params:(nullable NSDictionary *)params {
    //sslocal://main
    NSRange range = [url rangeOfString:@"://"];
    if(range.location != NSNotFound) {
        NSString *schema = [url substringFromIndex:NSMaxRange(range)];
        NSString *className = [self classNameWithURL:schema];
        if(className) {
            Class classInstance = NSClassFromString(className);
            if([classInstance conformsToProtocol:@protocol(LHRouteProtocol)]) {
                UIViewController *vc = [[classInstance alloc] initWithParams:params];
                vc.hidesBottomBarWhenPushed = YES;
                vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [[[LHWindowManager shareInstance] currentNavigationController] presentViewController:vc animated:YES completion:nil];
            }
        }
    }
}

- (BOOL)canOpenWithURL:(NSString *)url {
    NSRange range = [url rangeOfString:@"://"];
    if(range.location != NSNotFound) {
        NSString *schema = [url substringFromIndex:NSMaxRange(range)];
        NSString *className = [self classNameWithURL:schema];
        if(className) {
            Class classInstance = NSClassFromString(className);
            if([classInstance conformsToProtocol:@protocol(LHRouteProtocol)]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)classNameWithURL:(NSString *)url {
    static NSDictionary *nameDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nameDict = @{
            @"search" : @"LHSearchViewController",
            @"search_result" : @"LHSearchResultViewController",
            @"category_list" : @"LHMainCategoryViewController",
            @"login" : @"LHLoginViewController",
            @"collection" : @"LHMineCollectionViewController",
            @"setting" : @"LHSettingViewController",
            @"shop_detail" : @"LHShopDetailViewController",
            @"comment" : @"LHShopCommentViewController",
        };
    });
    NSString *name = [nameDict valueForKey:url];
    return name;
}

@end
