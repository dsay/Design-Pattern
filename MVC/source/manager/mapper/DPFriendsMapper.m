#import "DPFriendsMapper.h"
#import "DPFriend.h"
#import "DPUser.h"

@implementation DPFriendsMapper

+(void)importFriendsData:(NSDictionary *)friendsData
               toContext:(NSManagedObjectContext *)context
                 forUser:(DPUser *)user
                   error:(NSError *__autoreleasing *)error
{
    NSParameterAssert([friendsData isKindOfClass:[NSDictionary class]]);
    
    DPDataMapper *mapper = [DPDataMapper new];
    mapper.response = friendsData;
    NSArray *list = [mapper arrayFromKey:@"list"];
    
    for (NSDictionary *friendData in list)
    {
        mapper.response = friendData;
        DPFriend *friend;
        
        NSNumber *friendID = [mapper integerFromKey:@"id"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friendID == %@", friendID];
        NSArray *friends = [user.friends filteredSetUsingPredicate:predicate].allObjects;
        
        if (friends.count)
        {
            friend = friends.lastObject;
        }
        else
        {
            friend = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(DPFriend.class)
                                                   inManagedObjectContext:context];
        }
        
        friend.friendID = friendID ? : friend.friendID;
        friend.name = [mapper stringFromKey:@"name"] ? : friend.name;
        friend.location = [mapper stringFromKey:@"location"] ? : friend.location;
        
        if (!friend.user)
        {
            [user addFriendsObject:friend];
        }
    }
}
@end
