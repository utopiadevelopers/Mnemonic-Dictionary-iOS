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

@synthesize actionBar;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addToolbar
{
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
