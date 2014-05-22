#import "DPWeatherApi.h"

@implementation DPWeatherApi

+ (AFHTTPRequestOperation *)getWeatherCompletion:(completionBlock)completion
{
    AFHTTPRequestOperation *operation =
    [[DPApiClient shared].manager GET:@"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json"
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  
                                  NSParameterAssert([responseObject isKindOfClass:[NSDictionary class]]);
                                  if ([responseObject isKindOfClass:[NSDictionary class]])
                                      completion(responseObject, nil);
                                  else
                                      completion(nil, @"Bad data");
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  completion(nil, error.localizedDescription);
                              }];
    return operation;
}

@end
