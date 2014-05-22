#import <AFNetworking.h>

typedef  void (^completionBlock)(NSDictionary  *response, NSString *error) ;

@interface DPApiClient : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

+ (DPApiClient *)shared;

@end
