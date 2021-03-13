//
//  UIFont+LHExtention.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import "UIFont+LHExtention.h"

@implementation UIFont (LHExtention)

+(UIFont *)themeFontRegular:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
}

+(UIFont *)themeFontMedium:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
}

+(UIFont *)themeFontSemibold:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
}

@end
