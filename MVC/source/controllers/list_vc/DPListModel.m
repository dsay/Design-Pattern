#import "DPListModel.h"
#import "DPManagerProvider.h"

@interface DPListModel ()

@end

@implementation DPListModel

- (instancetype)initWithManagerProvider:(DPManagerProvider *)manager
{
    if (self = [super init])
    {
        NSParameterAssert(manager);
        _manager = manager;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    _title = @"List";
    
    [self updateData];
}

- (void)updateData
{

}

@end
