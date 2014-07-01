#import <Foundation/Foundation.h>

@protocol DPApiRequestBuilderProtocol <NSObject>

- (NSURLRequest *)loginUserWithEmail:(NSString *)email
                            password:(NSString *)password;

- (NSURLRequest *)getWeather;

@end
