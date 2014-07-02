#import "DPLoginModel.h"
#import "DPApiClientRequestBuilder.h"

typedef NS_ENUM(NSUInteger, DPLoginMStatus) {
    DPLoginMDefault,
    DPLoginMIncorrectInput,
    DPLoginMServerError,
};

@interface DPLoginModel()

@property (nonatomic, assign) DPLoginMStatus status;
@property (nonatomic, strong) DPManagerProvider *manager;
@property (nonatomic, assign) BOOL canEdit;

@end

@implementation DPLoginModel

- (instancetype)initWithManagerProvider:(DPManagerProvider *)manager
{
    NSParameterAssert(manager);
    if (self = [super init])
    {
        _manager = manager;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setStatus:DPLoginMDefault];
    _title = NSLocalizedString(@"Login", nil);
    _email = @"www@www.www";
    _password = @"wwwwww";
    _messageText = NSLocalizedString(@"Welcome to MVC app", nil);
    _emailPlaceholder = NSLocalizedString(@"Email", nil);
    _passwordPlaceholder = NSLocalizedString(@"Password", nil);
    _loginTitle = NSLocalizedString(@"Login", nil);
    _canEdit = YES;
}

- (void)setStatus:(DPLoginMStatus)status
{
    switch (status) {
        case DPLoginMDefault:
            _messageText = NSLocalizedString(@"Welcome to MVC app", nil);
            break;
        case DPLoginMIncorrectInput:
            _messageText = NSLocalizedString(@"Incorrect Input", nil);
            break;
        case DPLoginMServerError:
            _messageText = NSLocalizedString(@"Server Error", nil);
            break;
            
        default:
        break;
    }
}

#pragma mark - input Data
- (void)login
{
    if (!_canEdit)
        return;
    
    if (![self isEmailValid:self.email] ||
        ![self isPasswordtValid:self.password])
    {
        [self setStatus:DPLoginMIncorrectInput];
 
        NSParameterAssert(self.delegate);
        [self.delegate modelDidUpdate:self];
        return;
    }
    
    [self.manager loginUserWithEmail:self.email
                            password:self.password
                          completion:^(BOOL success){
                              
                              _canEdit = YES;
                              NSParameterAssert(self.delegate);
                              
                              if (success)
                              {
                                  [self.delegate modelDidLogin:self];
                              }
                              else
                              {
                                  [self setStatus:DPLoginMServerError];
                                  [self.delegate modelDidUpdate:self];
                              }
                          }];
    _canEdit = NO;
}

- (BOOL)shouldChangeEmailInRange:(NSRange)range
                 replacementText:(NSString *)text
{
    if (!_canEdit) return NO;
    
    if ([text isEqualToString:@" "]) return NO;
    
    _email = [_email stringByReplacingCharactersInRange:range
                                             withString:text];
    return YES;
}

- (BOOL)shouldChangePasswordtInRange:(NSRange)range
                     replacementText:(NSString *)text
{
    if (!_canEdit) return NO;

    if ([text isEqualToString:@" "]) return NO;
   
    _password = [_password stringByReplacingCharactersInRange:range
                                                   withString:text];
    return YES;
}

#pragma mark - Validation
- (BOOL)isEmailValid:(NSString *)email
{
    NSRegularExpression *regex =
    [NSRegularExpression
     regularExpressionWithPattern:@"^([a-zA-Z0-9_-]+\\.)*[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)*\\.[a-zA-Z]{2,6}$"
     options:NSRegularExpressionCaseInsensitive
     error:nil];
    
    return [[regex matchesInString:email
                           options:0
                             range:NSMakeRange(0, [email length])] count];
}

- (BOOL)isPasswordtValid:(NSString *)password
{
    if (password.length >= 6)
        return YES;
    
    return NO;
}

@end
