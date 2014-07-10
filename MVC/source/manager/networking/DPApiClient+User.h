#import "DPApiClient.h"

@interface DPApiClient (User)

- (AFHTTPRequestOperation *)loginUserWithEmail:(NSString *)email
                                      password:(NSString *)password
                                    completion:(CompletionBlock)completion;
@end
