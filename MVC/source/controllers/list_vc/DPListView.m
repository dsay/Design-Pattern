#import "DPListView.h"

@implementation DPListView
@synthesize tableView = tableView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self buildView];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
        [self buildView];
    
    return self;
}

- (void)buildView
{
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.tableView];

    NSDictionary *views = NSDictionaryOfVariableBindings(tableView);
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|[tableView]|"
                          options:0
                          metrics:nil
                          views:views]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|[tableView]|"
                          options:0
                          metrics:nil
                          views:views]];
}

@end
