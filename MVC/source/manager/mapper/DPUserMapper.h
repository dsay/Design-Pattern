#import <Foundation/Foundation.h>

@interface DPUserMapper : NSObject

+ (void)importUrerData:(NSDictionary *)userData
             toContext:(NSManagedObjectContext *)context
                 error:(NSError *__autoreleasing *)error;

@end
