#import "DPApiClientRequestBuilder.h"
#import <AFNetworking.h>

@interface DPApiClientRequestBuilder ()

@property (nonatomic, strong) AFHTTPRequestSerializer *serializer;

@end

@implementation DPApiClientRequestBuilder

- (instancetype)init
{
    if (self = [super init]) {
        _serializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}

- (NSURLRequest *)loginUserWithEmail:(NSString *)email
                            password:(NSString *)password

{
    NSParameterAssert(email);
    NSParameterAssert(password);
    
    NSDictionary *params = @{@"email": email,
                             @"password": password};
    
    NSError *error;
    NSMutableURLRequest *request =  [self.serializer requestWithMethod:@"GET"
                                                 URLString:@"http://www.mvc.com/demos/login"
                                                parameters:params
                                                     error:&error];
    NSAssert(error == nil, @"Not create request");
    return request;
}

- (NSURLRequest *)getWeather
{
    NSError *error;
    NSURLRequest *request =  [self.serializer requestWithMethod:@"GET"
                                                 URLString:@"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json"
                                                parameters:nil
                                                     error:&error];
    NSAssert(error == nil, @"Not create request");
    return request;
}


@end
