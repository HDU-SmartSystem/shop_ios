//
//  LHWalkNaviViewController.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/5/7.
//

#import "LHWalkNaviViewController.h"
#import <BaiduMapAPI_WalkNavi/BMKWalkNavigationManager.h>
#import <BaiduMapAPI_WalkNavi/BMKWalkCycleDefine.h>

@interface LHWalkNaviViewController ()

@end

@implementation LHWalkNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[BMKWalkNavigationManager sharedManager] startWalkNavi];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
