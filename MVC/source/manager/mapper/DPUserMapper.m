#import "DPUserMapper.h"

#import "DPUser.h"
#import "DPDataMapper.h"

static NSString * const kID = @"id";
static NSString * const kName = @"name";
static NSString * const kPassword = @"password";

@implementation DPUserMapper

+ (DPUser *)importUrerData:(NSDictionary *)userData
                 toContext:(NSManagedObjectContext *)context
                     error:(NSError *__autoreleasing *)error
{
    NSParameterAssert([userData isKindOfClass:[NSDictionary class]]);
    DPUser *user;
    
    NSFetchRequest *request =
    [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(DPUser.class)];
    request.fetchLimit = 1;
    
    NSArray *users = [context executeFetchRequest:request error:error];
    if (users.count)
    {
        user = users.lastObject;
    }
    else
    {
        user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(DPUser.class)
                                             inManagedObjectContext:context];
    }
    
    DPDataMapper *mapper = [DPDataMapper new];
    mapper.response = userData;
    
    user.userID = [mapper integerFromKey:kID] ? : user.userID;
    user.name = [mapper stringFromKey:kName] ? : user.name;
    user.password = [mapper stringFromKey:kPassword] ? : user.password;
    return user;
}

@end
