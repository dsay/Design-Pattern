#import "DPApiClient.h"

@interface DPUserApi : NSObject

+ (AFHTTPRequestOperation *)loginUserEmail:(NSString *)email
                                  password:(NSString *)password
                                completion:(completionBlock)completion;


@end
