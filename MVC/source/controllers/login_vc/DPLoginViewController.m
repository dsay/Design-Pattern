#import "DPLoginViewController.h"

#import "DPLoginView.h"
#import "DPLoginModel.h"

#import "DPListC.h"
#import "DPListM.h"

@interface DPLoginViewController ()
<
DPLoginModelDelegate,
DPModelDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) IBOutlet DPLoginView *view;

@end

@implementation DPLoginViewController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.model);
    NSParameterAssert(self.view);

    self.title = self.model.title;

    self.model.delegate = self;
    self.view.emailTextField.delegate = self;
    self.view.passwordTextField.delegate = self;
    
    [self.view.loginButton addTarget:self
                         action:@selector(pressLogin)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self reloadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat topInsets = self.topLayoutGuide.length;
    CGSize size = self.view.frame.size;
    size.height -= topInsets;
    
    self.view.scrollView.contentSize = size;
    [self.view.scrollView setContentOffset:CGPointMake(0, - topInsets) animated:NO];
}

- (void)reloadView
{
    self.view.emailTextField.text = self.model.email;
    self.view.passwordTextField.text = self.model.password;
    self.view.messageLabel.text = self.model.messageText;
    
    self.view.emailTextField.placeholder = self.model.emailPlaceholder;
    self.view.passwordTextField.placeholder = self.model.passwordPlaceholder;
    [self.view.loginButton setTitle:self.model.loginTitle forState:UIControlStateNormal];
}

#pragma mark - Model Delegate
- (void)modelDidUpdate:(id)model
{
    [self reloadView];
}

- (void)modelDidLogin:(DPLoginModel *)model
{

//        DPListC *controller = [DPListC new];
//        DPListM *model = [[DPListM alloc] initWithManagerProvider:self.manager];
//        controller.model = model;
//        
//        NSParameterAssert(self.delegate);
//        [self.delegate modelDidUpdate:self];
    
}

#pragma mark - View Selectors
- (void)pressLogin
{
    [self.view endEditing:YES];
    [self.model login];
}

#pragma mark - Text Field Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animationScrollViewToPoint:CGPointMake(0, - self.topLayoutGuide.length)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect positionOnView  = [self.view convertRect:textField.frame
                                           fromView:self.view.scrollView];
    
    CGPoint scrollTo = {0, (self.view.scrollView.contentOffset.y +
                            CGRectGetMinY(positionOnView) -
                            CGRectGetHeight(textField.frame)
                            - 100)};
    
    [self animationScrollViewToPoint:scrollTo];
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string
{
    if ([self.view.emailTextField isEqual:textField])
    {
      return [self.model shouldChangeEmailInRange:range replacementText:string];
    }
    else if ([self.view.passwordTextField isEqual:textField])
    {
      return [self.model shouldChangePasswordtInRange:range replacementText:string];
    }
    return NO; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        [self.view.passwordTextField becomeFirstResponder];
        return YES;
    }
    else if (textField.returnKeyType == UIReturnKeySend)
    {
        [self pressLogin];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)animationScrollViewToPoint:(CGPoint)point
{
    static BOOL isAnimated = NO;
    if (!isAnimated)
    {
        [UIView animateWithDuration:.35f animations:^{
            [self.view.scrollView setContentOffset:point animated:NO];
            isAnimated = YES;
        } completion:^(BOOL finished) {
            isAnimated = NO;
        }];
    }
    else
    {
        [self.view.scrollView setContentOffset:point animated:NO];
    }
}

@end
