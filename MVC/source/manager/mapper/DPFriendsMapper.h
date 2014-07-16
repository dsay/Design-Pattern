#import "DPDataMapper.h"

@class DPUser;
@interface DPFriendsMapper : NSObject

+ (void)importFriendsData:(NSDictionary *)friendsData
                toContext:(NSManagedObjectContext *)context
                  forUser:(DPUser *)user
                    error:(NSError *__autoreleasing *)error;

@end
