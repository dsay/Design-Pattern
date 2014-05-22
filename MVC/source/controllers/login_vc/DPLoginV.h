#import <UIKit/UIKit.h>

@interface DPLoginV : UIView

@property (nonatomic, strong) IBOutlet                        UIScrollView *scrollV;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) IBOutlet UITextField *emailTF;
@property (nonatomic, strong) IBOutlet UITextField *passwordTF;
@property (nonatomic, strong) IBOutlet UIButton *loginB;
@property (nonatomic, strong) IBOutlet UILabel *messageL;

@end
