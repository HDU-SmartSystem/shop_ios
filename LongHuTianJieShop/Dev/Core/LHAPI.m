//
//  LHAPI.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#import "LHAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>
#import "LHShopListModel.h"

@implementation LHAPI

+ (NSString *)host {
    return @"http://47.98.36.4:8629";
}


+ (void)requestMainShopListWithPage:(NSInteger)page completion:(nonnull completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/shop/child"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(page);
    
    [self requestWithURL:urlString params:params dataClass:[LHShopListModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)requestShopListWithCategory:(NSString *)category field:(NSString *)field keyword:(NSString *)keyword page:(NSInteger)page completion:(nonnull completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/search"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category"] = category ?: @"null";
    params[@"field"] = field ?: @"null";
    params[@"keyword"] = keyword ?: @"null";
    params[@"page"] = @(page);
    
    [self requestWithURL:urlString params:params dataClass:[LHShopListModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)requestWithURL:(NSString *)url params:(NSDictionary *)params dataClass:(Class)dataClass completion:(nonnull completionBlock)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JSONModel *model = [self generateModelFromResponseObject:responseObject dataClass:[LHShopListModel class]];
        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(model);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


+ (JSONModel *)generateModelFromResponseObject:(id)responseObject dataClass:(Class)dataClass {
    if([responseObject isKindOfClass: [NSDictionary class]]) {
        NSDictionary *dataDict = (NSDictionary *)responseObject;
        JSONModel *model = [[dataClass alloc] initWithDictionary:dataDict error:nil];
        return model;
    }
    return nil;
}
@end
