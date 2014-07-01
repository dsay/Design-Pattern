#import "DPManagerProvider.h"

#import "DPDataStorageRequestBuilder.h"
#import "DPApiClientRequestBuilder.h"

@implementation DPManagerProvider

- (instancetype)init
{
    if (self = [super init])
    {
        _apiClient = [DPApiClient new];
        
        DPApiClientRequestBuilder *apirequesrBuilder = [DPApiClientRequestBuilder new];
        _apiClient.requestBuilder = apirequesrBuilder;
        
        _dataStorage = [DPDataStorage new];
        
        DPDataStorageRequestBuilder *requestBuilder = [DPDataStorageRequestBuilder new];
        _dataStorage.requestBuilder = requestBuilder;
        
        DPContextProvider *contextProvider = [DPContextProvider new];
        _dataStorage.contextProvider = contextProvider;
    }
    return self;
}

#pragma mark - User
- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password
{
    NSURLRequest *request = [self.apiClient.requestBuilder loginUserWithEmail:email
                                                                     password:password];
    AFHTTPRequestOperation *operation =
    [self.apiClient.manager HTTPRequestOperationWithRequest:request
                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                            }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           
                                            }];
    [operation start];
}

@end
