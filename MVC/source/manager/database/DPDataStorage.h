#import <Foundation/Foundation.h>
#import "BBDataStorageProtocol.h"
#import "DPContextProvider.h"

@interface DPDataStorage : NSObject
<
DPDataStorageProtocol
>

@property (strong) id<DPRequestBuilderProtocol>    requestBuilder;
@property (strong) id<DPContextProviderProtocol>   contextProvider;

@end
