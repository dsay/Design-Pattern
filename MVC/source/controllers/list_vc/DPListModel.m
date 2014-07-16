#import "DPListModel.h"
#import "DPManagerProvider.h"
#import "DPFriend.h"

@interface DPListModel ()

@property (nonatomic, strong) DPUser *currentUser;

@end

@implementation DPListModel

- (instancetype)initWithManagerProvider:(DPManagerProvider *)provider
{
    if (self = [super init])
    {
        NSParameterAssert(provider);
        _provider = provider;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    _title = NSLocalizedString(@"List", nil);
    
    @weakify(self);
    [self.provider currentUser:^(DPUser *user) {
        @strongify(self);
        self.currentUser = user;
        _items = user.friends.allObjects;
        
        [self.delegate modelDidUpdate:self];
        [self updateData];
    }];
}

- (void)updateData
{
    if (self.currentUser)
    {
        [self startActivity];
    
        @weakify(self);
        [self.provider updateFriendsListForUser:self.currentUser
                                completion:^(NSArray *friends) {
                                    @strongify(self);
                                    [self finishActivity];
                                    if (friends.count)
                                    {
                                        self->_items = friends;
                                        [self.delegate modelDidUpdate:self];
                                    }
                                }];
    }
}

- (void)startActivity
{
    NSParameterAssert(self.delegate);
    if ([self.delegate respondsToSelector:@selector(modelDidStartActivity:)])
    {
        [self.delegate modelDidStartActivity:self];
    }
}

- (void)finishActivity
{
    NSParameterAssert(self.delegate);
    if ([self.delegate respondsToSelector:@selector(modelDidFinishActivity:)])
    {
        [self.delegate modelDidFinishActivity:self];
    }
}

- (NSInteger)numberOfSection
{
    return 1;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)index
{
    DPFriend *friend = self.items[index.row];
    return friend.name;
}

- (NSString *)locationAtIndexPath:(NSIndexPath *)index
{
    DPFriend *friend = self.items[index.row];
    return friend.location;}

@end
