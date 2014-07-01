#import "DPApiClient.h"

@implementation DPApiClient

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPRequestOperationManager new];
    }
    return self;
}

@end
