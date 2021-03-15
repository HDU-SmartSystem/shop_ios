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
+ (void)requestCollectionWithUserId:(NSString *)userId Page:(NSInteger)page completion:(completionBlock)completion;
+ (void)requestShopListWithCatogory:(NSString *)category Page:(NSInteger)page completion:(completionBlock)completion;
+ (void)requestShopListWithCategory:(NSString *)category field:(NSString *)field keyword:(NSString *)keyword page:(NSInteger)page completion:(nonnull completionBlock)completion;
+ (void)requestSearchRecommandWithcompletion:(completionBlock)completion;
+ (void)requestLoginWithUserName:(NSString *)userName passWord:(NSString *)passWord completion:(completionBlock)completion;
@end

NS_ASSUME_NONNULL_END
