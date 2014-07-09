#import <UIKit/UIKit.h>

@interface DPLoginView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *messageLabel;

- (void)decorateView;

@end
