#import <Foundation/Foundation.h>

#import "DPApiClient.h"
#import "DPDataStorage.h"


@interface DPManagerProvider : NSObject

@property (nonatomic, strong, readonly) DPApiClient *apiClient;
@property (nonatomic, strong, readonly) DPDataStorage *dataStorage;

- (void)loginUserWithEmail:(NSString *)email
                  password:(NSString *)password;
@end
