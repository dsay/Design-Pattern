#import "DPApiClient+User.h"

@implementation DPApiClient (User)

- (AFHTTPRequestOperation *)loginUserWithEmail:(NSString *)email
                                      password:(NSString *)password
                                    completion:(CompletionBlock)completion
{
    NSParameterAssert(email);
    NSParameterAssert(password);
    
    NSDictionary *params = @{@"email": email,
                             @"password": password};
    
    AFHTTPRequestOperation *operation =
    [self.manager GET:@"login"
           parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [self handleResponse:responseObject complete:completion];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [self handleError:error complete:completion];
              }];
    
    [operation start];
    return operation;
}

@end
