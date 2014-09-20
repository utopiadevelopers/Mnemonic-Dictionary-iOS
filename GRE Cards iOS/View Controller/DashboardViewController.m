//
//  DashboardViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController
{
    NSMutableArray* wordList;
}

@synthesize actionBar;
@synthesize wordLV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addToolbar];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupTableView
{
    wordList = [[DBManager sharedDBManager] getWordList];
    wordLV = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT_ADDITION, W(self.view), H(self.view))];
    [wordLV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wordLV setDataSource:self];
    [wordLV setDelegate:self];
    [self.view addSubview:wordLV];
}

#pragma TableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>[wordList count])
    {
        return [[UITableViewCell alloc] init];
    }
    else
    {
        UITableViewCell *cell = [wordLV dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        WordObject* wordObj = [wordList objectAtIndex:indexPath.row];
        [[cell textLabel] setText:[wordObj word]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wordList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Word List";
}

#pragma ToolBar

- (void) addToolbar
{
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0))
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    UIToolbar *actionToolBar = [[UIToolbar alloc] init];
    [actionToolBar setFrame:CGRectMake(0, 0, W(self.view), 80)];
    [actionToolBar setBackgroundColor:[UIColor grayColor]];
    
    UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Tool1" style:UIBarButtonItemStyleBordered target:self action:@selector(toolBarItem1:)];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:customItem1,nil];
//    [self.view addSubview:actionToolBar];
//    [actionToolBar setItems:toolbarItems];
//    self.actionBar = actionToolBar;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
