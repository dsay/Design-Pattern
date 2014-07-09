#import "DPLoginView.h"

@implementation DPLoginView

@synthesize scrollView = scrollView;
@synthesize emailTextField = emailTextField;
@synthesize passwordTextField = passwordTextField;
@synthesize loginButton = loginButton;
@synthesize messageLabel = messageLabel;
@synthesize indicatorView = indicatorView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self buildView];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
        [self buildView];
    
    return self;
}

- (void)buildView
{
    self.scrollView = [UIScrollView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *contentView = [UIView new];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.emailTextField = [UITextField new];
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.passwordTextField = [UITextField new];
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.messageLabel = [UILabel new];
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.indicatorView = [UIActivityIndicatorView new];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.scrollView];
    [self addSubview:self.indicatorView];

    [self.scrollView addSubview:contentView];

    [contentView addSubview:self.emailTextField];
    [contentView addSubview:self.passwordTextField];
    [contentView addSubview:self.loginButton];
    [contentView addSubview:self.messageLabel];
    

    NSDictionary *views = NSDictionaryOfVariableBindings(scrollView,
                                                         emailTextField,
                                                         passwordTextField,
                                                         loginButton,
                                                         messageLabel,
                                                         contentView);
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|[scrollView]|"
                          options:0
                          metrics:nil
                          views:views]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|[scrollView]|"
                          options:0
                          metrics:nil
                          views:views]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-0@250-[contentView]-0@250-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:views]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-0@500-[contentView]-0@500-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:views]];
    
    [contentView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:
                                 @"V:|[emailTextField]-[passwordTextField]-[loginButton]-[messageLabel]|"
                                 options:0
                                 metrics:nil
                                 views:views]];
    
    [contentView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[emailTextField]|"
                                 options:0
                                 metrics:nil
                                 views:views]];
    
    [contentView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[passwordTextField]|"
                                 options:0
                                 metrics:nil
                                 views:views]];
    
    [contentView addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[messageLabel]|"
                                 options:0
                                 metrics:nil
                                 views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:.5f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:loginButton
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:contentView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0]];
}

- (void)decorateView
{
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.passwordTextField setSecureTextEntry:YES];
    
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    
    self.emailTextField.returnKeyType = UIReturnKeyNext;
    self.passwordTextField.returnKeyType = UIReturnKeySend;

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
    
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.indicatorView.hidesWhenStopped = YES;
    [self.indicatorView setColor:[UIColor redColor]];
}

@end

