#import <Foundation/Foundation.h>
#import "DPModelProtocol.h"

@interface DPListModel : NSObject <DPModelProtocol>

@property (nonatomic, weak) id <DPModelDelegate, DPActivityDelegate> delegate;

@property (readonly) DPManagerProvider *provider;
@property (readonly) NSString *title;
@property (readonly) NSArray *items;

- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowInSection:(NSInteger)section;
- (NSString *)nameAtIndexPath:(NSIndexPath *)index;
- (NSString *)locationAtIndexPath:(NSIndexPath *)index;

- (void)updateData;

@end
