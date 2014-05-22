#import "DPLoginV.h"

@implementation DPLoginV

- (void)awakeFromNib
{
    [self buildView];
}

- (void)buildView
{
    self.emailTF.placeholder = @"Email";
    self.passwordTF.placeholder = @"Password";
    [self.loginB setTitle:@"Login" forState:UIControlStateNormal];

    self.emailTF.font = [UIFont systemFontOfSize:14];
    self.passwordTF.font = [UIFont systemFontOfSize:14];
    self.messageL.font = [UIFont systemFontOfSize:12];
    self.loginB.titleLabel.font = [UIFont systemFontOfSize:16];

    self.emailTF.textColor = [UIColor blackColor];
    self.passwordTF.textColor = [UIColor blackColor];
    self.messageL.textColor = [UIColor darkGrayColor];
    [self.loginB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    self.emailTF.tintColor = [UIColor redColor];
    self.passwordTF.tintColor = [UIColor redColor];
    self.loginB.tintColor = [UIColor redColor];
}

@end

