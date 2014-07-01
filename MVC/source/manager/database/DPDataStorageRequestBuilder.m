#import "DPDataStorageRequestBuilder.h"

@implementation DPDataStorageRequestBuilder

- (NSFetchRequest *)all
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@""];
    
    return request;
}
@end
