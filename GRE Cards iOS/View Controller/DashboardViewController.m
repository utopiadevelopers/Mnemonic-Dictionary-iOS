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
    wordList   = [[WordListViewController alloc] initWithWordListType:WordListTypeFull];
    favList    = [[WordListViewController alloc] initWithWordListType:WordListTypeFav];
    ignoreList = [[WordListViewController alloc] initWithWordListType:WordListTypeIgn];
}

- (void) setupTabBarExperience
{
    [self setViewControllers:@[wordList,favList,ignoreList]];
}

@end
