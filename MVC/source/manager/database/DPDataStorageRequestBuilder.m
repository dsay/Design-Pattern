#import "DPDataStorageRequestBuilder.h"

#import "DPUser.h"

@implementation DPDataStorageRequestBuilder

- (NSFetchRequest *)currentUser
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(DPUser.class)];
    
    return request;
}
@end
