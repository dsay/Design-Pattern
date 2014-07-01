#import "DPDataStorage.h"
#import "DPDataStorageRequestBuilder.h"

@implementation DPDataStorage

static DPDataStorage *_sharedInstance = nil;

- (NSString *)username
{
    return self.contextProvider.username;
}

- (NSURL *)databaseDirectory
{
    return self.contextProvider.databaseDirectory;
}

- (NSArray *)performFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSError* error = nil;
    NSArray* results = [self.contextProvider.mainContext executeFetchRequest:fetchRequest error:&error];
    NSAssert(error == nil, @"FRC fetch failed : %@", error);
    return results;
}

- (void)performFetchRequest:(NSFetchRequest *)request completeBlock:(void(^)(NSArray* results))block
{
    NSManagedObjectContext* fetchContext = [self.contextProvider createTemporaryContext];
    [fetchContext performBlock:^{
        NSFetchRequest *requestCopy = [request copy];
        [requestCopy setResultType:NSManagedObjectIDResultType];
        [requestCopy setSortDescriptors:nil];
        
        NSError *error = nil;
        NSArray *ids = [fetchContext executeFetchRequest:requestCopy error:&error];
    
        [self.contextProvider.mainContext performBlock:^{
            NSFetchRequest *modifiedRequest = [request copy];
            
            if (ids.count > 0)
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self IN %@", ids];
                [modifiedRequest setPredicate:predicate];
                [modifiedRequest setFetchBatchSize:request.fetchBatchSize];
                
                NSError* error = nil;
                NSArray* results = [self.contextProvider.mainContext executeFetchRequest:modifiedRequest error:&error];
                NSAssert(error == nil, @"Main context : %@", error);
                
                block(results);
            }
            else
            {
                block(nil);
            }
            
        }];
        
    }];
}

- (void)importRequestWithBlock:(NSDictionary* (^)(NSManagedObjectContext* context))block
                 completeBlock:(void(^)(NSDictionary* dictionary))complete
{
    NSManagedObjectContext *nestedContex = [self.contextProvider createTemporaryContext];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleDidSaveNotification:)
                                                name:NSManagedObjectContextDidSaveNotification
                                              object:nestedContex];
    
    [nestedContex performBlock:^{
        NSDictionary *objects = block(nestedContex);
        NSError *error = nil;
        
        NSMutableDictionary *objectIDs = [NSMutableDictionary new];
        for (NSString *key in objects.allKeys)
        {
            NSManagedObject *object = [objects objectForKey:key];
            if ([object.objectID isTemporaryID])
                [nestedContex obtainPermanentIDsForObjects:@[object] error:&error];
            
            [objectIDs setObject:object.objectID forKey:key];
        }
        
        [nestedContex save:&error];
        NSAssert(error == nil, @"Save nested Context : %@", error);
        
        [self.contextProvider.mainContext performBlock:^{
            NSMutableDictionary *permanentObjects = [NSMutableDictionary new];
            for (NSString *key in objectIDs.allKeys)
            {
                NSManagedObjectID *objectID = [objectIDs objectForKey:key];
                NSManagedObject *object = [self.contextProvider.mainContext objectWithID:objectID];
                [permanentObjects setObject:object forKey:key];
            }
            [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nestedContex];
            if (complete) complete(permanentObjects);
        }];
    }];
}

- (void)handleDidSaveNotification:(NSNotification *)notification
{
    if (notification.object != self.contextProvider.mainContext)
    {
        [self.contextProvider.mainContext performBlock:^{
            [self.contextProvider.mainContext mergeChangesFromContextDidSaveNotification:notification];
            
            
            NSError *error = nil;
            [self.contextProvider.mainContext save:&error];
            NSAssert(error == nil, @"Save main Context : %@", error);
        }];
    }
}


@end
