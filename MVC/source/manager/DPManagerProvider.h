#import <Foundation/Foundation.h>

#import "DPApiClient.h"
#import "DPDataStorage.h"

@interface DPManagerProvider : NSObject

@property (nonatomic, strong, readonly) DPApiClient *apiClient;
@property (nonatomic, strong, readonly) DPDataStorage *dataStorage;

- (AFHTTPRequestOperation *)loginUserWithEmail:(NSString *)email
                           password:(NSString *)password
                         completion:(void(^)(BOOL success))completion;
- (void)logout;

@end
