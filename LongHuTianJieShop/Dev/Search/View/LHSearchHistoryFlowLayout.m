//
//  LHSearchHistoryFlowLayout.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/13.
//

#import "LHSearchHistoryFlowLayout.h"

@implementation LHSearchHistoryFlowLayout

-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
    if(!attr.count) {
        return attr;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:attr.firstObject];
    NSUInteger numberOfLine = 1;
    for(NSUInteger i = 1; i < attr.count; i++) {
        UICollectionViewLayoutAttributes *curAttr = [attr objectAtIndex:i];
        UICollectionViewLayoutAttributes *preAttr = [attr objectAtIndex:i - 1];
        CGFloat left = CGRectGetMaxX(preAttr.frame) + self.lineSpacing;
        if(CGRectGetMinX(curAttr.frame) >= left) {
            CGRect frame = curAttr.frame;
            frame.origin.x = left;
            curAttr.frame = frame;
        } else {
            numberOfLine++;
            if(numberOfLine > self.numberOfLine) {
                break;
            }
        }
        [array addObject:curAttr];
    }
    return array;
}

@end
