//
//  DashboardViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import "DashboardViewController.h"

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
}

- (void) setupViewController
{
    wordList   = [[WordListViewController alloc] init];
    favList    = [[WordListViewController alloc] init];
    ignoreList = [[WordListViewController alloc] init];
}

- (void) setupTabBarExperience
{
    [self setViewControllers:@[wordList,favList,ignoreList]];
}

@end
