//
//  DashboardViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import "DashboardViewController.h"
#import "MainHeaderView.h"

@interface DashboardViewController ()
{
    WordListViewController *wordList;
    WordListViewController *favList;
    WordListViewController *ignoreList;
}
@end

@implementation DashboardViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setupViewController];
    [self setupTabBarExperience];
    [self setupNavigationBar];
}

- (void) setupNavigationBar
{
    MainHeaderView *headerView = [[MainHeaderView alloc] initMainHeaderWithParent:self WithTitle:@"Word List" backButtonRequired:NO];
    [[self navigationItem] setTitleView:headerView];
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [settingsButton addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setTitle:@"b" forState:UIControlStateNormal];
    [settingsButton setTitle:@"b" forState:UIControlStateHighlighted];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[settingsButton titleLabel] setFont:FONT_ICON(22)];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [settingsButton setFrame:CGRectMake(0,20,40,40)];
    
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    [[self navigationItem] setRightBarButtonItem:settingBarButton];
}

- (void) setupViewController
{
    wordList   = [[WordListViewController alloc] initWithWordListType:WordListTypeFull];
    favList    = [[WordListViewController alloc] initWithWordListType:WordListTypeFav];
    ignoreList = [[WordListViewController alloc] initWithWordListType:WordListTypeIgn];
    
    [self setViewControllers:@[wordList,favList,ignoreList]];
}

- (void) setupTabBarExperience
{
    [[self tabBar] setBackgroundColor:[UIColor blackColor]];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    
    [tabBarItem1 setTitle:@"Word List"];
    //[tabBarItem1 setSelectedImage:IMG(@"tab_list.png")];
    //[tabBarItem1 setImage:IMG(@"star_select.png")];
    
    [tabBarItem2 setTitle:@"Favorites"];
    [tabBarItem2 setSelectedImage:IMG(@"tab_fav.png")];
    
    [tabBarItem3 setTitle:@"Ignores"];
    [tabBarItem3 setSelectedImage:IMG(@"tab_ign.png")];
    
    
}

- (void) openSettings
{
    [self presentViewController:[CommonFunction getSettingsViewController] animated:YES completion:^{}];
}

@end
