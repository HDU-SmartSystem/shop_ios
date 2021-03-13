//
//  UIColor+LHExtention.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "UIColor+LHExtention.h"

@implementation UIColor (LHExtention)

+ (UIColor *)colorWithHexString:(NSString *)hexString{
    return [self colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    if (hexString == nil || hexString.length == 0) {
        return [UIColor clearColor];
    }
    
    NSString *rgbString = [hexString substringFromIndex:1];

    unsigned int rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:rgbString];
    if (![scanner scanHexInt:&rgb]) {
        return nil;
    }
    return [self colorWithRGB:rgb alpha:alpha * 255.0];
}

+ (UIColor *)colorWithRGB:(uint)rgb alpha:(uint)alpha {
    return [self colorWithRed:(CGFloat)((rgb & 0xFF0000) >> 16) / 255.0
                        green:(CGFloat)((rgb & 0x00FF00) >> 8) / 255.0f
                         blue:(CGFloat)(rgb & 0x0000FF) / 255.0
                        alpha:alpha / 255.0];
}
@end
