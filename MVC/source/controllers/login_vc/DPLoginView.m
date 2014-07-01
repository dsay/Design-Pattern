#import "DPLoginView.h"

@implementation DPLoginView

- (void)awakeFromNib
{
    [self buildView];
}

- (void)buildView
{
    self.emailTextField.font = [UIFont systemFontOfSize:14];
    self.passwordTextField.font = [UIFont systemFontOfSize:14];
    self.messageLabel.font = [UIFont systemFontOfSize:12];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:16];

    self.emailTextField.textColor = [UIColor blackColor];
    self.passwordTextField.textColor = [UIColor blackColor];
    self.messageLabel.textColor = [UIColor darkGrayColor];
    [self.loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    self.emailTextField.tintColor = [UIColor redColor];
    self.passwordTextField.tintColor = [UIColor redColor];
    self.loginButton.tintColor = [UIColor redColor];
}

@end

