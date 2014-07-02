#import <AFNetworking.h>
#import "DPApiRequestBuilderProtocol.h"

typedef  void (^completionBlock)(NSDictionary *response, NSString *error) ;

@interface DPApiClient : NSObject

@property (nonatomic, strong) id <DPApiRequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (AFHTTPRequestOperation *)loginUserWithEmail:(NSString *)email
                                      password:(NSString *)password
                                    completion:(completionBlock)completion;

@end
