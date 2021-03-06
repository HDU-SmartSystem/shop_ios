//
//  LHSearchBarView.m
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/6.
//

#import "LHSearchBarView.h"
#import "LHCommonDefine.h"
#import "UIColor+LHExtention.h"
#import "UIViewAdditions.h"

@interface LHSearchBarView ()
@property(nonatomic,strong) UIView *searchView;
@end

@implementation LHSearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 33 - 15 * 3 , 34)];;
    self.searchView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.searchView.layer.borderColor = [UIColor colorWithHexString:@"#e8e8e8"].CGColor;
    self.searchView.layer.borderWidth = 0.5;
    self.searchView.layer.cornerRadius = self.searchView.height / 2.f;
    [self addSubview:self.searchView];
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 16, 16)];
    searchIcon.image = [UIImage imageNamed:@"search_icon"];
    [self.searchView addSubview:searchIcon];
    
    self.textInput = [[UITextField alloc] initWithFrame:CGRectMake(30, 7, self.searchView.width - 30, 20)];
    self.textInput.background = NULL;
    self.textInput.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.textInput.textColor = [UIColor colorWithHexString:@"#333333"];
    self.textInput.tintColor = [UIColor colorWithHexString:@"#333333"];
    self.textInput.returnKeyType = UIReturnKeySearch;
    UIButton *cleanButton = [self.textInput valueForKey:@"_clearButton"];
    [cleanButton setImage:[UIImage imageNamed:@"serach_input_clear"] forState:UIControlStateNormal];
    self.textInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchView addSubview:self.textInput];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(self.searchView.right + 15, 11, 33, 22)];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backButton setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:self.backButton];
}

@end
