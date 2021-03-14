//GENERATED CODE , DON'T EDIT
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@interface LHUserDataModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *nickname;
@property (nonatomic, copy , nullable) NSString *token;
@property (nonatomic, copy , nullable) NSString *userId;
@property (nonatomic, copy , nullable) NSString *headImg;
@property (nonatomic, copy , nullable) NSString *phone;
@end

@interface LHUserModel : JSONModel 

@property (nonatomic, copy , nullable) NSString *message;
@property (nonatomic, copy , nullable) NSString *code;
@property (nonatomic, strong , nullable) LHUserDataModel *data ;  
@end


NS_ASSUME_NONNULL_END
//END OF HEADER