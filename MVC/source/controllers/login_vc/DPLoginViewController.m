#import "DPLoginViewController.h"

#import "DPLoginView.h"
#import "DPLoginModel.h"

#import "DPListViewController.h"
#import "DPListModel.h"

@interface DPLoginViewController ()
<
DPLoginModelDelegate,
DPModelDelegate,
DPActivityDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong)  DPLoginView *view;
@property (nonatomic, strong)  UIView *selectedView;

@end

@implementation DPLoginViewController

#pragma mark - Life cycle
- (void)loadView
{
    [super loadView];
    
    self.view = [DPLoginView new];
}

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self reloadView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadView
{
    [self.view decorateView];
    
    self.view.emailTextField.text = self.model.email;
    self.view.passwordTextField.text = self.model.password;
    self.view.messageLabel.text = self.model.messageText;
    
    self.view.emailTextField.placeholder = self.model.emailPlaceholder;
    self.view.passwordTextField.placeholder = self.model.passwordPlaceholder;
    [self.view.loginButton setTitle:self.model.loginTitle forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
}

#pragma mark - Model Delegate
- (void)modelDidUpdate:(id)model
{
    [self reloadView];
}

- (void)modelDidLogin:(DPLoginModel *)model
{
    DPListViewController *controller = [DPListViewController new];
    DPListModel *listModel = [[DPListModel alloc] initWithManagerProvider:self.model.manager];
    controller.model = listModel;

    [self.navigationController pushViewController:controller animated:YES];
}

- (void)modelDidStartActivity:(id)model
{
    [self.view.indicatorView startAnimating];
}

- (void)modelDidFinishActivity:(id)model
{
    [self.view.indicatorView stopAnimating];
}
#pragma mark - View Selectors
- (void)pressLogin 
{
    [self.view endEditing:YES];
    [self.model login];
}

#pragma mark - Text Field Delegate
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.selectedView = textField;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.selectedView = nil;
    return YES;
}
#pragma mark - keyboardWasShown:(NSNotification
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.view.scrollView.contentInset = contentInsets;
    self.view.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, self.selectedView.frame.origin) )
    {
        CGRect brect = [self.selectedView convertRect:self.selectedView.frame toView:self.view];
        [self.view.scrollView scrollRectToVisible:brect animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.view.scrollView.contentInset = contentInsets;
    self.view.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
