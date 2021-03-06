//
//  NSString+LHExtention.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (LHExtention)

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)maxWidth;
- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)maxHeight;
@end

NS_ASSUME_NONNULL_END
