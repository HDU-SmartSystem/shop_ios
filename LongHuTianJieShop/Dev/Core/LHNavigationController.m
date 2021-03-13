//
//  LHNavigationController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHNavigationController.h"

@interface LHNavigationController ()<UINavigationControllerDelegate>

@end

@implementation LHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isRoot = (viewController == navigationController.viewControllers.firstObject);
    navigationController.interactivePopGestureRecognizer.enabled = !isRoot;
}




@end
