#import "DPApiClient.h"

@interface DPWeatherApi : NSObject

+ (AFHTTPRequestOperation *)getWeatherCompletion:(completionBlock)completion;

@end
