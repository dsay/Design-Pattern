#import <Foundation/Foundation.h>
#import "DPModelProtocol.h"

@protocol DPListMProtocol

- (void)listMDidUpdateData;
- (void)showController:(UIViewController *)controller;

@end

@interface DPListModel : NSObject<DPModelProtocol>

@property (nonatomic, weak) id <DPListMProtocol> delegate;
@property (readonly) DPManagerProvider *manager;

@property (readonly) NSArray *items;
@property (readonly) NSString *title;

@end
