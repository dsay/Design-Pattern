#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^resultsBlock)(NSArray*);
typedef void(^importResultsBlock)(NSDictionary*);
typedef NSDictionary* (^importBlock)(NSManagedObjectContext* context);

@protocol DPRequestBuilderProtocol <NSObject>

- (NSFetchRequest *)currentUser;

@end

@protocol DPDataStorageProtocol <NSObject>

@property (readonly) id<DPRequestBuilderProtocol>   requestBuilder;
@property (readonly) NSString                     * username;
@property (readonly) NSURL                        * databaseDirectory;

- (NSArray *)performFetchRequest:(NSFetchRequest *)fetchRequest;
- (void)performFetchRequest:(NSFetchRequest *)fetchRequest
              completeBlock:(resultsBlock)block;
- (void)importRequestWithBlock:(importBlock)block
                 completeBlock:(importResultsBlock)complete;

@end
