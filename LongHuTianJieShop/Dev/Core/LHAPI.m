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
#import "LHShopSearchRecommandModel.h"
#import "LHUserModel.h"
#import "LHShopGoodModel.h"
#import "LHShopDetailModel.h"
#import "LHShopCommentModel.h"
#import "LHAccoutManager.h"
#import "LHShopCaptChaModel.h"

@implementation LHAPI

+ (NSString *)host {
    return @"http://120.55.51.51:8629";
}

+ (NSString *)LHHost {
    return @"http://192.168.3.105:5000";
}

+ (void)requestCaptchaWithPhone:(NSString *)phone completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/sms/send"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phone ?: @"null";
    params[@"type"] = @(1);

    [self requestWithURL:urlString params:params dataClass:[LHShopCaptChaModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)requestCaptchaWithPhone:(NSString *)phone code:(NSString *)code password:(NSString *)password completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/register"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phone ?: @"null";
    params[@"password"] = password ?: @"null";
    params[@"code"] = code ?: @"null";

    [self postWithURL:urlString params:params dataClass:[LHShopCaptChaModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
    
}
+ (void)reqeustRecordWithShopId:(NSString *)shopId userId:(NSString *)userId behavior:(NSString *)behavior {
    NSString *urlString = [[self LHHost] stringByAppendingString:@"/record"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId ?: @"null";
    params[@"shopId"] = shopId ?: @"null";
    params[@"behavior"] = behavior ?: @"null";

    [self requestWithURL:urlString params:params dataClass:[LHShopCaptChaModel class] completion:^(JSONModel * _Nonnull model) {
    }];
    
}

+ (void)requestRecommandWithUserId:(NSString *)userId Page:(NSInteger)page completion:(completionBlock)completion {
    NSString *urlString = [[self LHHost] stringByAppendingString:@"/user/recommand"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId ?: @"null";
    params[@"page"] = @(page);

    [self requestWithURL:urlString params:params dataClass:[LHShopListModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
    
}
+ (void)reqeustShopDetailWithShopId:(NSString *)shopId userId:(NSString *)userId completion:(completionBlock)completion {
    [self reqeustRecordWithShopId:shopId userId:userId behavior:@"pv"];
    NSString *urlString = [[self host] stringByAppendingString:[NSString stringWithFormat:@"/shop/%@?",shopId]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId ?: @"null";

    [self requestWithURL:urlString params:params dataClass:[LHShopDetailModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}


+ (void)requestCollectionWithUserId:(NSString *)userId Page:(NSInteger)page completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/user/collection"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId ?: @"null";
    params[@"page"] = @(page);
    
    [self requestWithURL:urlString params:params dataClass:[LHShopListModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
    
}

+ (void)requestGoodWithShopId:(NSString *)shopId Page:(NSInteger)page completion:(completionBlock)completion {
    NSString *urlString = [[self LHHost]  stringByAppendingString:@"/good"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopId"] = shopId ?: @"null";
    params[@"page"] = @(page);
    
    [self requestWithURL:urlString params:params dataClass:[LHShopGoodModel class] completion:^(JSONModel * _Nonnull model) {
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

+(void)requestSearchRecommandWithcompletion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/hotWords"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start"] = @"0";
    params[@"end"] = @"5";
    [self requestWithURL:urlString params:params dataClass:[LHShopSearchRecommandModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+(void)requestShopListWithCatogory:(NSString *)category Page:(NSInteger)page completion:(completionBlock)completion {
    if(!category) {
        category = @"null";
    }
    NSString *urlString = [[[self host] stringByAppendingString:@"/shop"] stringByAppendingString:[NSString stringWithFormat:@"/%@/",category]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(page);
    
    [self requestWithURL:urlString params:params dataClass:[LHShopListModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)requestLoginWithUserName:(NSString *)userName passWord:(NSString *)passWord completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/login"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = userName;
    params[@"password"] = passWord;

    [self postWithURL:urlString params:params dataClass:[LHUserModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)requestCommentWithShopId:(NSString *)shopId userId:(NSString *)userId completion:(completionBlock)completion {
    NSString *urlString = [[self LHHost]  stringByAppendingString:@"/comment"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId;
    params[@"shopId"] = shopId;
    params[@"sort"] = @"likes";
    [self requestWithURL:urlString params:params dataClass:[LHShopCommentModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)addColletionWithShopId:(NSString *)shopId userId:(NSString *)userId completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/user/collection"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId;
    params[@"shopId"] = shopId;
    [self postWithURL:urlString params:params dataClass:[LHUserModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
}

+ (void)commitCommentWithParams:(NSDictionary *)params completion:(completionBlock)completion {
    NSString *urlString = [[self host] stringByAppendingString:@"/comment"];
    [self postWithURL:urlString params:params dataClass:[LHUserModel class] completion:^(JSONModel * _Nonnull model) {
        if(completion) {
            completion(model);
        }
    }];
    
}


+ (void)requestWithURL:(NSString *)url params:(NSDictionary *)params dataClass:(Class)dataClass completion:(nonnull completionBlock)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JSONModel *model = [self generateModelFromResponseObject:responseObject dataClass:dataClass];
        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(model);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params dataClass:(Class)dataClass completion:(nonnull completionBlock)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if([[LHAccoutManager shareInstance] isLogin]) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[LHAccoutManager shareInstance].user.token forHTTPHeaderField:@"Authorization"];
    }
    [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JSONModel *model = [self generateModelFromResponseObject:responseObject dataClass:dataClass];
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
