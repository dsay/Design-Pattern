#import "DPManagerProvider.h"

#import "DPDataStorageRequestBuilder.h"
#import "DPApiClientRequestBuilder.h"

#import "DPDataMapper.h"
#import "DPUserMapper.h"

@interface DPManagerProvider ()
{
    BOOL isPersistenStoreValid;
}

@property (nonatomic, strong) DPContextProvider *contextProvider;

@end

@implementation DPManagerProvider

- (instancetype)init
{
    if (self = [super init])
    {
        isPersistenStoreValid = NO;
        
        _apiClient = [DPApiClient new];
        
        DPApiClientRequestBuilder *apirequesrBuilder = [DPApiClientRequestBuilder new];
        _apiClient.requestBuilder = apirequesrBuilder;
        
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
    return [self.apiClient loginUserWithEmail:email
                                     password:password
                                   completion:^(NSDictionary *response, NSString *error) {
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

@end
