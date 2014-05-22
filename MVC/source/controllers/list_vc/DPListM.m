#import "DPListM.h"

#import "DPWeatherApi.h"

@interface DPListM ()

@end

@implementation DPListM

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _title = @"List";
    
    [self updateData];
}

- (void)updateData
{
    AFHTTPRequestOperation *operation = [DPWeatherApi getWeatherCompletion:^(NSDictionary *response, NSString *error) {
        
    }];
    [operation start];
}

@end
