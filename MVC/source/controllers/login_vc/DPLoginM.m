#import "DPLoginM.h"

#import "DPUserApi.h"

#import "DPListC.h"
#import "DPListM.h"

typedef NS_ENUM(NSUInteger, DPLoginMStatus) {
    DPLoginMDefault,
    DPLoginMIncorrectInput,
    DPLoginMServerError,
};

@interface DPLoginM()

@property (nonatomic, assign) DPLoginMStatus status;
@property (nonatomic, assign) BOOL canEdit;

@end

@implementation DPLoginM

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _status = DPLoginMDefault;
    _title = @"Login";
    _email = @"";
    _password = @"";
    _messageText = @"Welcome to MVC app";
    _canEdit = YES;
}

- (void)setStatus:(DPLoginMStatus)status
{
    switch (status) {
        case DPLoginMDefault:
            _messageText = @"Welcome to MVC app";
            break;
        case DPLoginMIncorrectInput:
            _messageText = @"Incorrect Input";
            break;
        case DPLoginMServerError:
            _messageText = @"Server Error";
            break;
            
        default:
        break;
    }
    NSParameterAssert(self.delegate);
    [self.delegate loginMDidUpdateData];
}

- (void)loginSuccess
{
    DPListC *controller = [DPListC new];
    DPListM *model = [DPListM new];
    controller.model = model;
    
    [self.delegate showController:controller];
}

#pragma mark - input Data
- (void)login
{
    if (!_canEdit)
        return;
    
    if (![self isEmailValid:self.email] || ![self isPasswordtValid:self.password]) {
        self.status = DPLoginMIncorrectInput;
        return;
    }

    AFHTTPRequestOperation *operation = [DPUserApi loginUserEmail:self.email
                                                         password:self.password
                                                       completion:^(NSDictionary *response, NSString *error) {
        if ([self.email isEqualToString:@"www@www.ww"]) {
            [self loginSuccess];
        }else
            self.status = DPLoginMServerError;
        
        _canEdit = YES;
    }];
    _canEdit = NO;
    [operation start];
}

- (void)setEmail:(NSString *)email
{
    if (!_canEdit)
        return;
    
    NSParameterAssert(self.delegate);
    _email = email;
    [self.delegate loginMDidUpdateData];
}

- (void)setPassword:(NSString *)password
{
    if (!_canEdit)
        return;
    
    NSParameterAssert(self.delegate);
    _password = password;
    [self.delegate loginMDidUpdateData];
}

#pragma mark - Validation
- (BOOL)isEmailValid:(NSString *)email
{
    if (![self isTextValid:email])
        return NO;
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^([a-zA-Z0-9_-]+\\.)*[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)*\\.[a-zA-Z]{2,6}$"
                                  options:NSRegularExpressionCaseInsensitive error:nil];
    
    return [[regex matchesInString:email
                           options:0
                             range:NSMakeRange(0, [email length])] count];
}

- (BOOL)isPasswordtValid:(NSString *)password
{
    if ([self isTextValid:password] && password.length >= 6)
        return YES;
    
    return NO;
}

- (BOOL)isTextValid:(NSString *)text
{
    return (![text isEqualToString:@""]);
}

@end
