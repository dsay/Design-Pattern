#import "DPListTableViewCell.h"

@implementation DPListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self decorateView];
    }
    return self;
}

- (void)decorateView
{
    self.textLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
