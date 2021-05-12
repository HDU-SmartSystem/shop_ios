//GENERATED CODE , DON'T EDIT
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@protocol LHShopCommentDataModel<NSObject>
@end

@interface LHShopCommentDataModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *text;
@property (nonatomic, copy , nullable) NSString *allRate;
@end

@interface LHShopCommentModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *message;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, strong , nullable) NSArray<LHShopCommentDataModel> *data;
@end


NS_ASSUME_NONNULL_END
//END OF HEADER