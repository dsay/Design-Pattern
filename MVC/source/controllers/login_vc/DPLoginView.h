#import <UIKit/UIKit.h>

@interface DPLoginView : UIView

@property (nonatomic, strong) IBOutlet                        UIScrollView *scrollView;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;

@end
