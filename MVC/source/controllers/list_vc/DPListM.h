#import <Foundation/Foundation.h>

@protocol DPListMProtocol

- (void)listMDidUpdateData;
- (void)showController:(UIViewController *)controller;

@end

@interface DPListM : NSObject

@property (nonatomic, weak) id <DPListMProtocol> delegate;
@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, strong, readonly) NSString *title;

@end
