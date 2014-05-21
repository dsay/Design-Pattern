#import "DPLoginC.h"

#import "DPLoginV.h"
#import "DPLoginM.h"

@interface DPLoginC ()<DPLoginVProtocol, DPLoginMProtocol, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet DPLoginV *view;

@end

@implementation DPLoginC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.delegate = self;
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
    [self.view reloadView];
}

#pragma mark - View Selectors
- (void)pressLogin
{    
    [self.view endEditing:YES];
    [self.model login];
}

#pragma mark - Model Delegate
- (void)loginMDidUpdateData
{
    [self.view reloadView];
}

- (void)showController:(UIViewController *)controller;
{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - View Delegate
- (NSString *)loginVEmail
{
    return self.model.email;
}

- (NSString *)loginVPassword
{
    return self.model.password;
}

- (NSString *)loginVMessageText
{
    return self.model.messageText;
}

#pragma mark - Text Field Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animationScrollView:self.view.scrollV
                      toPoint:CGPointMake(0, 0)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect positionOnView  = [self.view convertRect:textField.frame
                                           fromView:self.view.scrollV];
    
    CGPoint scrollTo = {0, (self.view.scrollV.contentOffset.y +
                            CGRectGetMinY(positionOnView) -
                            CGRectGetHeight(textField.frame)
                            )};
    
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
    
    return NO;
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
