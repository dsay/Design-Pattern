#import <Foundation/Foundation.h>
#import "DPManagerProvider.h"

typedef void(^CompletionBlock)(void);
@protocol DPModelProtocol <NSObject>

- (instancetype)initWithManagerProvider:(DPManagerProvider *)manager;

@end

@protocol DPModelDelegate <NSObject>

- (void)modelDidUpdate:(id)model;

@end