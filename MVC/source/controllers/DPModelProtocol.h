#import <Foundation/Foundation.h>

@class DPManagerProvider;
@protocol DPModelProtocol <NSObject>

- (instancetype)initWithManagerProvider:(DPManagerProvider *)manager;

@end

@protocol DPModelDelegate <NSObject>

- (void)modelDidUpdate:(id)model;

@end

@protocol DPActivityDelegate <NSObject>
@optional
- (void)modelDidStartActivity:(id)model;
- (void)modelDidFinishActivity:(id)model;

@end