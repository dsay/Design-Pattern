#import "DPApiClient+Friends.h"

@implementation DPApiClient (Friends)

- (AFHTTPRequestOperation *)friendsListForUserID:(NSNumber *)userID
                                      completion:(CompletionBlock)completion
{
    NSParameterAssert(userID);
    
    NSDictionary *params = @{@"userID": userID};
    
    AFHTTPRequestOperation *operation =
    [self.manager GET:@"friends"
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
