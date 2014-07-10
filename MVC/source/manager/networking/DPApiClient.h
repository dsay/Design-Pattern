#import <AFNetworking.h>

typedef void (^CompletionBlock)(NSDictionary *response, NSString *error);

@interface DPApiClient : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (void)handleResponse:(id)responseObject complete:(CompletionBlock)completion;
- (void)handleError:(NSError *)error complete:(CompletionBlock)completion;

@end
