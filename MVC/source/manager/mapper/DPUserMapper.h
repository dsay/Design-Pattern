#import <Foundation/Foundation.h>

@class DPUser;
@interface DPUserMapper : NSObject

+ (DPUser *)importUrerData:(NSDictionary *)userData
                 toContext:(NSManagedObjectContext *)context
                     error:(NSError *__autoreleasing *)error;

@end
