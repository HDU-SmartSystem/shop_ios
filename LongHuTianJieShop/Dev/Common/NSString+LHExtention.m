//
//  NSString+LHExtention.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "NSString+LHExtention.h"

@implementation NSString (LHExtention)

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)maxWidth
{
    return [self sizeWithFont:font width:maxWidth].height;
}

- (CGFloat)widthWithFont:(UIFont *)font height:(CGFloat)maxHeight
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{ NSFontAttributeName : font }
                                     context:nil];
    CGFloat width = ceil(rect.size.width);
    return width;
}

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)maxWidth {
    return [self sizeWithFont:font width:maxWidth maxLine:0];
}

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)maxWidth maxLine:(NSInteger)maxLine {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = font.lineHeight;
    style.maximumLineHeight = font.lineHeight;
    CGFloat maxHeight = maxLine ? maxLine * font.lineHeight : CGFLOAT_MAX;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}
                                     context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}

@end
