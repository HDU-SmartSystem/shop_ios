//GENERATED CODE , DON'T EDIT
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@interface LHShopDetailDataTypeModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *id;
@property (nonatomic, copy , nullable) NSString *name;
@end

@interface LHShopDetailDataModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *mallId;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *serviceRate;
@property (nonatomic, copy , nullable) NSString *qualityRate;
@property (nonatomic, copy , nullable) NSString *commentNum;
@property (nonatomic, copy , nullable) NSString *consumePer;
@property (nonatomic, copy , nullable) NSString *environmentRate;
@property (nonatomic, assign) BOOL commented;
@property (nonatomic, copy , nullable) NSString *tag;
@property (nonatomic, copy , nullable) NSString *picurl;
@property (nonatomic, copy , nullable) NSString *stars;
@property (nonatomic, copy , nullable) NSString *address;
@property (nonatomic, assign) BOOL collected;
@property (nonatomic, copy , nullable) NSString *commentNums;
@property (nonatomic, strong , nullable) LHShopDetailDataTypeModel *type ;  
@property (nonatomic, copy , nullable) NSString *id;
@end

@interface LHShopDetailModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *message;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, strong , nullable) LHShopDetailDataModel *data ;  
@end


NS_ASSUME_NONNULL_END
//END OF HEADER