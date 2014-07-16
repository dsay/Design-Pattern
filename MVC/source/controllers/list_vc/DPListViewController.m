#import "DPListViewController.h"

#import "DPListModel.h"
#import "DPListView.h"
#import "DPListTableViewCell.h"
#import "DPRefreshView.h"

@interface DPListViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
DPModelDelegate,
DPActivityDelegate
>

@property (nonatomic, strong) DPListView *view;

@end

static NSString *kCellIdentifier = @"ListTableViewCell";

@implementation DPListViewController

#pragma mark - Life cycle
- (void)loadView
{
    [super loadView];
    self.view = [DPListView new];
}

- (void)viewDidLoad
{
    NSParameterAssert(self.model);
    NSParameterAssert(self.view);
    
    [super viewDidLoad];
    
    [self.view.tableView registerClass:DPListTableViewCell.class
                forCellReuseIdentifier:kCellIdentifier];
    
    self.title = self.model.title;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.view.tableView.dataSource = self;
    self.view.tableView.delegate = self;
    self.model.delegate = self;

    [self reloadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.model updateData];
}

- (void)reloadView
{
    [self.view.tableView reloadData];
    [self.view layoutIfNeeded];
}

#pragma mark - Model Delegate
- (void)modelDidUpdate:(id)model
{
    [self reloadView];
}

- (void)modelDidStartActivity:(id)model
{
    DPRefreshView *view = [[DPRefreshView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [UIView animateWithDuration:.35f animations:^{
        self.view.tableView.tableHeaderView = view;
    }];
}

- (void)modelDidFinishActivity:(id)model
{
    [UIView animateWithDuration:.35f animations:^{
        self.view.tableView.tableHeaderView = nil;
    }];
}

#pragma mark - TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.model numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model numberOfRowInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = [self.model nameAtIndexPath:indexPath];
    cell.detailTextLabel.text = [self.model locationAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
