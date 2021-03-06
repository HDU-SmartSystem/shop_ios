//
//  LHBaseViewController.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import <UIKit/UIKit.h>
#import "LHRoute.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHBaseViewController : UIViewController <LHRouteProtocol>
@property(nonatomic,strong) UIView *customNavBar;
@property(nonatomic,strong) UILabel *titleLabel;
- (void)goBack;
@end

NS_ASSUME_NONNULL_END
