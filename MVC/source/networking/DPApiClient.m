#import "DPApiClient.h"

@implementation DPApiClient

 + (DPApiClient *)shared
{
    static DPApiClient *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [DPApiClient new];
    });
    
    return sharedMyManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPRequestOperationManager new];
    }
    return self;
}

@end
