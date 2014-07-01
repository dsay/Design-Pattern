#import "DPContextProvider.h"

@interface DPContextProvider ()

@property (assign) BOOL isSetUp;
@property (nonatomic, strong) NSManagedObjectContext* mainContext;
@property (strong) NSURL* databaseDirectory;

@end

@implementation DPContextProvider

@synthesize username = _username;
@synthesize mainContext = _mainContext;
@synthesize coordinator = _coordinator;

- (void)setupForUsername:(NSString *)username
{
    NSAssert(_isSetUp == NO, @"Setup for username must be called");
    NSAssert(_mainContext == nil, @"Context should be empty.");
    
    id objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    
    self.databaseDirectory = ({
        NSURL* directory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                   inDomains:NSUserDomainMask] lastObject];
        directory = [directory URLByAppendingPathComponent:username isDirectory:YES];
        if (![[NSFileManager defaultManager] fileExistsAtPath:directory.absoluteString]){
            NSError* error = nil;
            BOOL success = [[NSFileManager defaultManager] createDirectoryAtURL:directory
                                                    withIntermediateDirectories:YES
                                                                     attributes:nil
                                                                          error:&error];
            NSAssert(success == YES, @"Unable to create user directory: %@", error.localizedDescription);
        }

        directory;
    });
    
    NSString* databaseName = [NSString stringWithFormat:@"database-%@", username];
    NSURL* databaseURL = [self.databaseDirectory URLByAppendingPathComponent:databaseName];
    
    {/// Adding store to PSC
        NSError* error = nil;
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:databaseURL
                                        options:nil
                                          error:&error];
        NSAssert(error == nil, @"Cannot add store at %@ to PSC", databaseURL);
    }
    
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.mainContext setPersistentStoreCoordinator:_coordinator];
    self.mainContext.mergePolicy = NSRollbackMergePolicy;
   
    self.isSetUp = YES;
    _username = username;
}

- (NSManagedObjectContext *)createTemporaryContext
{
    NSAssert(self.mainContext != nil, @"Context should not be empty.");
    NSManagedObjectContext* fetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    fetchContext.persistentStoreCoordinator = self.mainContext.persistentStoreCoordinator;
    fetchContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    return fetchContext;
}

- (NSManagedObjectContext *)createChildContext
{
    NSAssert(self.mainContext != nil, @"Context should not be empty.");
    NSManagedObjectContext* fetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    fetchContext.parentContext = self.mainContext;
    fetchContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    return fetchContext;
}

- (void)cleanDBForCurrentUser
{
    NSAssert(self.isSetUp == YES, @"Setup for username must be called");
    NSAssert(self.mainContext != nil, @"Context should not be empty.");
    
    NSURL* databaseURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    databaseURL = [databaseURL URLByAppendingPathComponent:_username];
    
    NSString* databaseName = [NSString stringWithFormat:@"database-%@", _username];
    databaseURL = [databaseURL URLByAppendingPathComponent:databaseName];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] removeItemAtURL:databaseURL error:&error]) [NSException raise:@"database is epsent" format:@""];
    self.isSetUp = NO;
    self.mainContext = nil;
  
    [self setupForUsername:_username];
}

- (void)setMainContext:(NSManagedObjectContext *)context
{
    _mainContext = context;
}

- (NSManagedObjectContext*)mainContext
{
    NSAssert(_mainContext != nil, @"Setup for username must be called before access to mainContext");
    return _mainContext;
}

- (NSPersistentStoreCoordinator*)coordinator
{
    NSAssert(_coordinator != nil, @"Setup for username must be called before access to coordinator");
    return _coordinator;
}

@end
