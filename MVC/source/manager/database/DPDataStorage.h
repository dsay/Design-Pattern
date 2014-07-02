#import <Foundation/Foundation.h>
#import "DPDataStorageProtocol.h"
#import "DPContextProvider.h"

@interface DPDataStorage : NSObject
<
DPDataStorageProtocol
>

@property (strong) id<DPRequestBuilderProtocol>    requestBuilder;
@property (strong) id<DPContextProviderProtocol>   contextProvider;

@end
