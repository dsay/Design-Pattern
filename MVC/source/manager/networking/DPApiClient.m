#import "DPApiClient.h"
#import "DPDataMapper.h"

static NSString * const kStatus = @"status";
static NSString * const kData = @"data";

@implementation DPApiClient

- (instancetype)init
{
    if (self = [super init])
    {
        _manager = [AFHTTPRequestOperationManager new];
    }
    return self;
}

- (AFHTTPRequestOperation *)loginUserWithEmail:(NSString *)email
                                      password:(NSString *)password
                                    completion:(completionBlock)completion
{
    
    NSURLRequest *request = [self.requestBuilder loginUserWithEmail:email
                                                           password:password];
    AFHTTPRequestOperation *operation = [self.manager
                                         HTTPRequestOperationWithRequest:request
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
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
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             completion(nil, error.localizedDescription);
                                         }];
    [operation start];
    return operation;
}


@end
