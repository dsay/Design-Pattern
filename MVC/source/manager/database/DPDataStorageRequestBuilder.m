#import "DPDataStorageRequestBuilder.h"

#import "User.h"

@implementation DPDataStorageRequestBuilder

- (NSFetchRequest *)currentUser
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(User.class)];
    
    return request;
}
@end
