#import "DPListViewController.h"

#import "DPListModel.h"
#import "DPListView.h"

@interface DPListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet DPListView *view;

@end

@implementation DPListViewController

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
