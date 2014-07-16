#import "DPManagerProvider.h"

#import "DPDataStorageRequestBuilder.h"

#import "DPDataMapper.h"
#import "DPUserMapper.h"
#import "DPFriendsMapper.h"

#import "DPApiClient+User.h"
#import "DPApiClient+Friends.h"

@interface DPManagerProvider ()
{
    BOOL isPersistenStoreValid;
}

@property (nonatomic, strong) DPContextProvider *contextProvider;

@end

@implementation DPManagerProvider

#pragma mark - Life cycle
- (instancetype)init
{
    if (self = [super init])
    {
        isPersistenStoreValid = NO;
        
        _apiClient = [DPApiClient new];
        
        _dataStorage = [DPDataStorage new];
        
        DPDataStorageRequestBuilder *requestBuilder = [DPDataStorageRequestBuilder new];
        _dataStorage.requestBuilder = requestBuilder;        
    }
    return self;
}

#pragma mark - User
- (NSOperation *)loginUserWithEmail:(NSString *)email
                           password:(NSString *)password
                         completion:(void (^)(BOOL success))completion
{
    @weakify(self);
    return [self.apiClient loginUserWithEmail:email
                                     password:password
                                   completion:^(NSDictionary *response, NSString *error) {
                                       @strongify(self);
                                       if (!error && response)
                                       {
                                           _contextProvider = [DPContextProvider new];
                                           [_contextProvider setupForUsername:email];
                                           _dataStorage.contextProvider = _contextProvider;
                                           
                                           isPersistenStoreValid = YES;
                                           [self.dataStorage  importRequestWithBlock:^NSDictionary *(NSManagedObjectContext *context) {
                                               NSError *error;
                                               [DPUserMapper importUrerData:response
                                                                  toContext:context
                                                                      error:&error];
                                               NSAssert(error == nil, @"User data not parse");
                                               
                                               return @{};
                                           } completeBlock:^(NSDictionary *result) {
                                               completion(YES);
                                           }];
                                       }
                                       else
                                       {
                                           completion(NO);
                                       }
                                   }];
}

- (void)logout
{
    isPersistenStoreValid = NO;
    _contextProvider = nil;
    _dataStorage.contextProvider = nil;
}

- (void)currentUser:(void (^)(DPUser *user))block
{
  NSFetchRequest *request = [self.dataStorage.requestBuilder currentUser];
  [self.dataStorage performFetchRequest:request
                          completeBlock:^(NSArray *array) {
                              NSParameterAssert(array.count);
                              DPUser *user = array.lastObject;
                              block(user);
  }];
}
#pragma mark - Friends
- (NSOperation *)updateFriendsListForUser:(DPUser *)user
                          completion:(void (^)(NSArray *))completion
{
    @weakify(self, user);
    return [self.apiClient friendsListForUserID:user.userID
                                     completion:^(NSDictionary *response, NSString *error) {
                                         @strongify(self, user);
                                         if (!error && response)
                                         {
                                             NSManagedObjectID *userID = user.objectID;
                                             [self.dataStorage  importRequestWithBlock:^NSDictionary *(NSManagedObjectContext *context) {
                                                 NSError *error;
                                                 DPUser *user = (DPUser *)[context objectWithID:userID];
                                                 [DPFriendsMapper importFriendsData:response
                                                                          toContext:context
                                                                            forUser:user
                                                                              error:&error];
                                                 NSAssert(error == nil, @"Friends List not parse");
                                                 
                                                 return @{@"user": user};
                                             } completeBlock:^(NSDictionary *result) {
                                                 
                                                 DPUser *user = result[@"user"];
                                                 completion(user.friends.allObjects);
                                             }];
                                         }
                                         else
                                         {
                                             completion(nil);
                                         }
                                     }];
}
@end
