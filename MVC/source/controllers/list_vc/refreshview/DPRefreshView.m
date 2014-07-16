#import "DPRefreshView.h"

@implementation DPRefreshView

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
    UIActivityIndicatorView *activity =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:activity];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(activity);
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|[activity]|"
                          options:0
                          metrics:nil
                          views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:activity
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:activity
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:activity
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.f
                                                      constant:0]];

    activity.color = [UIColor redColor];
    [activity startAnimating];
}

@end
