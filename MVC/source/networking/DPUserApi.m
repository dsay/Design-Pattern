#import "DPUserApi.h"

@implementation DPUserApi

+(AFHTTPRequestOperation *)loginUserEmail:(NSString *)email
                                 password:(NSString *)password
                               completion:(completionBlock)completion
{
    NSDictionary *params = @{@"email": email,
                             @"password": password};
    
    AFHTTPRequestOperation *operation =
    [[DPApiClient shared].manager GET:@"http://mvc/api/login"
                           parameters:params
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  completion(nil, nil);
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  completion(nil, nil);
                              }];
    return operation;
}

@end
