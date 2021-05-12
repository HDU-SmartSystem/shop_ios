//GENERATED CODE , DON'T EDIT
#import "LHShopCommentModel.h"
@implementation LHShopCommentModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation LHShopCommentDataModel
+ (JSONKeyMapper*)keyMapper
{
  NSDictionary *dict = @{
    @"allRate": @"all_rate",
  };
  return [[JSONKeyMapper alloc]initWithModelToJSONBlock:^NSString *(NSString *keyName) {
     return dict[keyName]?:keyName;
  }];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

