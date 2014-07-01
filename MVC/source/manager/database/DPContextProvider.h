#import <CoreData/CoreData.h>

@protocol DPContextProviderProtocol <NSObject>

@property (readonly) NSString                       * username;
@property (readonly) NSURL                          * databaseDirectory;
@property (readonly) NSManagedObjectContext         * mainContext;
@property (readonly) NSPersistentStoreCoordinator   * coordinator;


- (NSManagedObjectContext *) createTemporaryContext;
- (NSManagedObjectContext *) createChildContext;

@end

@interface DPContextProvider : NSObject
<
DPContextProviderProtocol
>

- (void)setupForUsername:(NSString*)username;
- (void)cleanDBForCurrentUser;

@end
