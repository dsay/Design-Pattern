#import "DPApiClient.h"

#import "DPDataMapper.h"

static NSString * const kBaseURL = @"http://www.mvc.com/demos/";
static NSString * const kStatus = @"status";
static NSString * const kData = @"data";

@implementation DPApiClient

- (instancetype)init
{
    if (self = [super init])
    {
        NSURL *baseURL = [NSURL URLWithString:kBaseURL];
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void)handleResponse:(id)responseObject complete:(CompletionBlock)completion
{
    DPDataMapper *mapper = [DPDataMapper new];
    [mapper setResponse:responseObject];
    
    if ([[mapper stringFromKey:kStatus] isEqualToString:@"OK"])
    {
        if ([mapper dictionaryForKey:kData])
        {
            completion([mapper dictionaryForKey:kData], nil);
        }
    }
    else
    {
        completion(nil, @"Error user authorization !");
    }
#if DEBUG
    NSLog(@"Server response:%@", responseObject);
#endif
}

- (void)handleError:(NSError *)error complete:(CompletionBlock)completion
{
    completion(nil, error.localizedDescription);
    
#if DEBUG
    NSLog(@"Server error:%@", error);
#endif
}

@end
