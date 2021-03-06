//
//  LHSearchViewModel.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchViewModel.h"
#import "LHRoute.h"

@interface LHSearchViewModel ()
@property(nonatomic,copy) NSDictionary *params;
@end

@implementation LHSearchViewModel

- (instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super init]) {
        self.params = params;
    }
    return self;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = textField.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category"] = self.params[@"category"];
    params[@"field"] = @"name";
    params[@"keyword"] = text;
    [[LHRoute shareInstance] pushViewControllerWithURL:@"sslocal://search_result" params:params];
    return YES;
}

@end
