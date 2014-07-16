#import <Foundation/Foundation.h>

#import "DPApiClient.h"
#import "DPDataStorage.h"

#import "DPUser.h"

@interface DPManagerProvider : NSObject

@property (nonatomic, strong, readonly) DPApiClient *apiClient;
@property (nonatomic, strong, readonly) DPDataStorage *dataStorage;

- (NSOperation *)loginUserWithEmail:(NSString *)email
                           password:(NSString *)password
                         completion:(void(^)(BOOL success))completion;
- (void)logout;
- (void)currentUser:(void (^)(DPUser *user))block;

- (NSOperation *)updateFriendsListForUser:(DPUser *)user
                         completion:(void(^)(NSArray *friends))completion;

@end
