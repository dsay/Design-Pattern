#import "DPLoginC.h"

#import "DPLoginV.h"
#import "DPLoginM.h"

@interface DPLoginC ()<DPLoginMProtocol, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet DPLoginV *view;

@end

@implementation DPLoginC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.model);
    NSParameterAssert(self.view);

    self.model.delegate = self;
    self.view.emailTF.delegate = self;
    self.view.passwordTF.delegate = self;
    
    [self.view.loginB addTarget:self
                         action:@selector(pressLogin)
               forControlEvents:UIControlEventTouchUpInside];
    
    self.title = self.model.title;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat topInsets = self.topLayoutGuide.length;
    CGSize size = self.view.frame.size;
    size.height -= topInsets;
    
    self.view.scrollV.contentSize = size;
    [self.view.scrollV setContentOffset:CGPointMake(0, - topInsets) animated:NO];
}

- (void)reloadView
{
    self.view.emailTF.text = self.model.email;
    self.view.passwordTF.text = self.model.password;
    self.view.messageL.text = self.model.messageText;
}

#pragma mark - Model Delegate
- (void)loginMDidUpdateData
{
    [self reloadView];
}

- (void)showController:(UIViewController *)controller;
{
    [self.navigationController pushViewController:controller animated:YES];
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
    [self animationScrollView:self.view.scrollV
                      toPoint:CGPointMake(0, - self.topLayoutGuide.length)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect positionOnView  = [self.view convertRect:textField.frame
                                           fromView:self.view.scrollV];
    
    CGPoint scrollTo = {0, (self.view.scrollV.contentOffset.y +
                            CGRectGetMinY(positionOnView) -
                            CGRectGetHeight(textField.frame)
                            - 100)};
    
    [self animationScrollView:self.view.scrollV
                      toPoint:scrollTo];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *value = [self valueChangeCharacters:textField.text
                                          inRange:range
                                replacementString:string];
    
    if ([self.view.emailTF isEqual:textField]) {
        [self.model setEmail:value];
    }else if ([self.view.passwordTF isEqual:textField]){
        [self.model setPassword:value];
    }
    
    return NO;   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        UITextField *nextField = [self nextFieldAfter:textField
                                                 from:self.view.textFields];
        [nextField becomeFirstResponder];
        
        return YES;
    }else if (textField.returnKeyType == UIReturnKeySend){
        [self pressLogin];
    }
    
    [textField resignFirstResponder];
    return YES;
}

@end
