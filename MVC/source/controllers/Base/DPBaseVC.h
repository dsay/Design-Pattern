#import <UIKit/UIKit.h>

@interface DPBaseVC : UIViewController

//Text Field Methods
- (NSString *)valueChangeCharacters:(NSString *)text
                            inRange:(NSRange)range
                  replacementString:(NSString *)string;

- (void)animationScrollView:(UIScrollView *)scrollV toPoint:(CGPoint)point;
- (UITextField *)nextFieldAfter:(UITextField *)textField from:(NSArray *)array;

@end

