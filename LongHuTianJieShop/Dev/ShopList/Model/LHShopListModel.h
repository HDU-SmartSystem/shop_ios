//GENERATED CODE , DON'T EDIT
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@protocol LHShopListDataModel<NSObject>
@end

@interface LHShopListDataTypeModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *id;
@property (nonatomic, copy , nullable) NSString *name;
@end

@interface LHShopListDataModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *mallId;
@property (nonatomic, copy , nullable) NSString *name;
@property (nonatomic, copy , nullable) NSString *views;
@property (nonatomic, copy , nullable) NSString *serviceRate;
@property (nonatomic, copy , nullable) NSString *qualityRate;
@property (nonatomic, copy , nullable) NSString *commentNum;
@property (nonatomic, copy , nullable) NSString *consumePer;
@property (nonatomic, copy , nullable) NSString *environmentRate;
@property (nonatomic, copy , nullable) NSString *tag;
@property (nonatomic, copy , nullable) NSString *picurl;
@property (nonatomic, copy , nullable) NSString *stars;
@property (nonatomic, copy , nullable) NSString *address;
@property (nonatomic, strong , nullable) LHShopListDataTypeModel *type ;  
@property (nonatomic, copy , nullable) NSString *id;
@end

@interface LHShopListModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *message;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, strong , nullable) NSArray<LHShopListDataModel> *data;
@end


NS_ASSUME_NONNULL_END
//END OF HEADER