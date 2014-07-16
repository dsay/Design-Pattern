#import "DPLoginModel.h"
#import "DPManagerProvider.h"

typedef NS_ENUM(NSUInteger, DPLoginMStatus) {
    DPLoginMDefault,
    DPLoginMIncorrectInput,
    DPLoginMServerError,
};

static NSString *   const kEmailRegularExpression =
@"^([a-zA-Z0-9_-]+\\.)*[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)*\\.[a-zA-Z]{2,6}$";
static NSUInteger   const kPasswordMinLength = 6;


@interface DPLoginModel()

@property (nonatomic, assign) DPLoginMStatus status;
@property (nonatomic, assign) BOOL canEdit;

@end

@implementation DPLoginModel

#pragma mark - Life cycle
- (instancetype)initWithManagerProvider:(DPManagerProvider *)provider
{
    if (self = [super init])
    {
        NSParameterAssert(provider);
        _provider = provider;
        
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
    _emailDefaultText = NSLocalizedString(@"Email", nil);
    _passwordDefaultText = NSLocalizedString(@"Password", nil);
    _loginTitle = NSLocalizedString(@"Login", nil);
    _canEdit = YES;
}

- (void)setStatus:(DPLoginMStatus)status
{
    switch (status) {
        case DPLoginMDefault:
            _messageText = NSLocalizedString(@"Welcome to MVC", nil);
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

#pragma mark - Activity
- (void)login
{
    if (!_canEdit) return;
    
    NSParameterAssert(self.delegate);
    
    if (![self isEmailValid:self.email] ||
        ![self isPasswordValid:self.password])
    {
        [self setStatus:DPLoginMIncorrectInput];
        [self.delegate modelDidUpdate:self];
        return;
    }
    
    @weakify(self);
    [self.provider loginUserWithEmail:self.email
                            password:self.password
                          completion:^(BOOL success){
                              @strongify(self);
                              
                              [self finishActivity];
                              
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
    [self startActivity];
}

- (void)startActivity
{
    _canEdit = NO;

    NSParameterAssert(self.delegate);
    if ([self.delegate respondsToSelector:@selector(modelDidStartActivity:)])
    {
        [self.delegate modelDidStartActivity:self];
    }
}

- (void)finishActivity
{
    _canEdit = YES;

    NSParameterAssert(self.delegate);
    if ([self.delegate respondsToSelector:@selector(modelDidFinishActivity:)])
    {
        [self.delegate modelDidFinishActivity:self];
    }
}

#pragma mark - Validation
- (BOOL)isEmailValid:(NSString *)email
{
    NSRegularExpression *regex =
    [NSRegularExpression
     regularExpressionWithPattern:kEmailRegularExpression
     options:NSRegularExpressionCaseInsensitive
     error:nil];
    
    return [[regex matchesInString:email
                           options:0
                             range:NSMakeRange(0, [email length])] count];
}

- (BOOL)isPasswordValid:(NSString *)password
{
    if (password.length >= kPasswordMinLength)
        return YES;
    
    return NO;
}

@end
