//
//  WordListViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordListViewController.h"
#import "SettingsViewController.h"
#import "WordInfoViewController.h"
#import "MainHeaderView.h"

#define SEARCH_BAR_HEIGHT 44.0f

@interface WordListViewController ()
{
    NSMutableArray* wordList;
    NSMutableArray* sectionHeading;
    NSMutableDictionary *sectionWordList;
    NSMutableArray* searchSectionHeading;
    NSMutableDictionary *searchSectionWordList;
    UIView *searchBar;
    BOOL isSearching;
}
@end

@implementation WordListViewController

@synthesize actionBar;
@synthesize wordLV;
@synthesize wordListType;

-(id) initWithWordListType:(WordListType) listType
{
    self = [super init];
    if(self)
    {
        wordListType = listType;
        sectionWordList       = [[NSMutableDictionary alloc] init];
        sectionHeading        = [[NSMutableArray alloc] init];
        searchSectionWordList = [[NSMutableDictionary alloc] init];
        searchSectionHeading  = [[NSMutableArray alloc] init];
        isSearching = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVariables];
    [self setupNavigationBar];
    [self setupSearchBar];
    [self setupTableView];
}

- (void) initVariables
{
    if (wordListType == WordListTypeFull)
    {
        wordList = [[DBManager sharedDBManager] getWordList];
    }
    else if(wordListType == WordListTypeFav)
    {
        wordList = [[DBManager sharedDBManager] getWordList];
    }
    else
    {
        wordList = [[DBManager sharedDBManager] getWordList];
    }
    
    [self setupMutuableDic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) setupNavigationBar
{
    [[self navigationItem] setTitle:@"Word List"];
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [settingsButton addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setTitle:FONT_ICON_GEAR forState:UIControlStateNormal];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[settingsButton titleLabel] setFont:FONT_ICON(22)];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [settingsButton setFrame:CGRectMake(0,20,40,40)];
    [settingsButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [threeButton addTarget:self action:@selector(toggleDrawer) forControlEvents:UIControlEventTouchUpInside];
    [threeButton setTitle:FONT_ICON_THREE_BARS forState:UIControlStateNormal];
    [threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[threeButton titleLabel] setFont:FONT_ICON(22)];
    [threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [threeButton setFrame:CGRectMake(0,0,40,40)];
    [threeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    UIBarButtonItem *threeBarButton = [[UIBarButtonItem alloc] initWithCustomView:threeButton];
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    UIBarButtonItem *negativeSpace = [[UIBarButtonItem alloc] init];
    [negativeSpace setWidth:-15.0f];
    
    UIBarButtonItem *postiveSpace = [[UIBarButtonItem alloc] init];
    [postiveSpace setWidth:40.0f];

    [[self navigationItem] setRightBarButtonItems:@[postiveSpace,settingBarButton]];
    [[self navigationItem] setLeftBarButtonItems:@[negativeSpace,threeBarButton]];
}


- (void) setupSearchBar
{
    searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W([self view]), SEARCH_BAR_HEIGHT)];
    [searchBar setBackgroundColor:UIColorFromRGB(SEARCH_BAR_COLOR)];
    
    UITextView *searchTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 7, W(searchBar)-20, 30)];
    [searchTextView setBackgroundColor:[UIColor whiteColor]];
    [[searchTextView layer] setCornerRadius:3];
    [searchBar addSubview:searchTextView];
}

- (void) setupTableView
{
    wordLV = [[UITableView alloc] initWithFrame:CGRectMake(0,0, W([self view]), H([self view])-NAVIGATION_BAR_HEIGHT)];
    [wordLV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wordLV setDataSource:self];
    [wordLV setDelegate:self];
    [wordLV setSectionIndexBackgroundColor:[UIColor clearColor]];
    [wordLV setTableHeaderView:searchBar];
    [[self view] addSubview:wordLV];
}

- (void) setupMutuableDic
{
    for (WordObject *word in wordList)
    {
        NSString *w_str = [[[[word word] substringFromIndex:0] substringToIndex:1] uppercaseString];
        
        if([sectionHeading containsObject:w_str])
        {
            NSMutableArray * array = [sectionWordList objectForKey:w_str];
            [array addObject:word];
            [sectionWordList setObject:array forKey:w_str];
        }
        else
        {
            NSMutableArray * array = [[NSMutableArray alloc] init];
            [array addObject:word];
            [sectionWordList setObject:array forKey:w_str];
            [sectionHeading addObject:w_str];
        }
    }
}

#pragma Search

- (void) setupSearchMutuableDic:(NSMutableArray*) data
{
    for (WordObject *word in data)
    {
        NSString *w_str = [[[[word word] substringFromIndex:0] substringToIndex:1] uppercaseString];
        
        if([searchSectionHeading containsObject:w_str])
        {
            NSMutableArray * array = [searchSectionWordList objectForKey:w_str];
            [array addObject:word];
            [searchSectionWordList setObject:array forKey:w_str];
        }
        else
        {
            NSMutableArray * array = [[NSMutableArray alloc] init];
            [array addObject:word];
            [searchSectionWordList setObject:array forKey:w_str];
            [searchSectionHeading addObject:w_str];
        }
    }
}

#pragma TableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WordObject* wordObj;
    
    if(isSearching)
        wordObj = [[searchSectionWordList objectForKey:[searchSectionHeading objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    else
        wordObj = [[sectionWordList objectForKey:[sectionHeading objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    
    static NSString * cellIdentifier = @"WordListCell";
    
    WordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WordListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell updateWord:wordObj];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(isSearching)
        return [searchSectionHeading count];
    else
        return [sectionWordList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WordListTableViewCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isSearching)
        return [[searchSectionWordList objectForKey:[searchSectionHeading objectAtIndex:section]] count];
    else
        return [[sectionWordList objectForKey:[sectionHeading objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isSearching)
        return [searchSectionHeading objectAtIndex:section];
    else
        return [sectionHeading objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(isSearching)
        return searchSectionHeading;
    else
        return sectionHeading;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [wordLV deselectRowAtIndexPath:indexPath animated:NO];
    WordListTableViewCell *cell = (WordListTableViewCell*)[wordLV cellForRowAtIndexPath:indexPath];
    
    WordInfoViewController *wvc = [[WordInfoViewController alloc] initWithWord:[cell wordObj]];
    [[self navigationController] pushViewController:wvc animated:YES];
}

- (void) openSettings
{
    [[self navigationController] pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

-(void) sneakPeak
{
    //[[self mm_drawerController] bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void) toggleDrawer
{
    //[[self mm_drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
