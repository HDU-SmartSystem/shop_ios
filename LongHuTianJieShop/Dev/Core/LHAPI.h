//
//  LHAPI.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^completionBlock)(JSONModel *model);

@interface LHAPI : NSObject
+ (void)requestMainShopListWithPage:(NSInteger)page completion:(completionBlock)completion;
+ (void)requestShopListWithCategory:(NSString *)category field:(NSString *)field keyword:(NSString *)keyword page:(NSInteger)page completion:(nonnull completionBlock)completion;
@end

NS_ASSUME_NONNULL_END
