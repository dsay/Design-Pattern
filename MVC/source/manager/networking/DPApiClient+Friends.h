#import "DPApiClient.h"

@interface DPApiClient (Friends)

- (AFHTTPRequestOperation *)friendsListForUserID:(NSNumber *)userID
                                      completion:(CompletionBlock)completion;

@end
