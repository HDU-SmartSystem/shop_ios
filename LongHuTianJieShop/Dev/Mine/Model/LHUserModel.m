//GENERATED CODE , DON'T EDIT
#import "LHUserModel.h"
@implementation LHUserModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation LHUserDataModel
+ (JSONKeyMapper*)keyMapper
{
  NSDictionary *dict = @{
    @"userId": @"id",
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

