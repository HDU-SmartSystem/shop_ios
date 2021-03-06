//
//  LHWindowManager.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHWindowManager.h"
#import "SceneDelegate.h"

@implementation LHWindowManager

+ (instancetype)shareInstance {
    static LHWindowManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LHWindowManager alloc] init];
    });
    return instance;
}

-(UIWindow *)window {
    UIScene *scene = [UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    SceneDelegate *sceneDelegate = (SceneDelegate *)scene.delegate;
    if([sceneDelegate isKindOfClass:[SceneDelegate class]]) {
        return sceneDelegate.window;
    }
    return nil;
}

- (UINavigationController *)currentNavigationController {
    UITabBarController *tabBarController = (UITabBarController *)[self window].rootViewController;
    if([tabBarController isKindOfClass:[UITabBarController class]]) {
        return tabBarController.selectedViewController;
    }
    return nil;
}

@end
