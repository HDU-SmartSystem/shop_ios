//GENERATED CODE , DON'T EDIT
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@protocol LHShopGoodDataModel<NSObject>
@end

@interface LHShopGoodDataModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *price;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *picurl;
@end

@interface LHShopGoodModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *message;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, strong , nullable) NSArray<LHShopGoodDataModel> *data;
@end


NS_ASSUME_NONNULL_END
//END OF HEADER