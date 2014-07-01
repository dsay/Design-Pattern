#import "DPListM.h"


@interface DPListM ()

@property (nonatomic, strong) DPManagerProvider *manager;

@end

@implementation DPListM

- (instancetype)initWithManagerProvider:(DPManagerProvider *)manager
{
    NSParameterAssert(manager);
    if (self = [super init]) {
        [self setup];
        _manager = manager;
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
