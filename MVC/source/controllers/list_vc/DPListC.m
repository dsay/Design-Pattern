#import "DPListC.h"

#import "DPListM.h"
#import "DPListV.h"

@interface DPListC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet DPListV *view;

@end

@implementation DPListC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - TableV Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
