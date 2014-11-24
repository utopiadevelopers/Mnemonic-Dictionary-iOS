//
//  WordListViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordListViewController.h"
#import "WordInfoViewController.h"

#define SEARCH_BAR_HEIGHT 44.0f

@interface WordListViewController ()
{
    NSMutableArray* wordList;
    NSMutableArray* sectionHeading;
    NSMutableDictionary *sectionWordList;
    NSMutableArray* searchSectionHeading;
    NSMutableDictionary *searchSectionWordList;
    
    BOOL isSearching;
}
@end

@implementation WordListViewController

@synthesize actionBar;
@synthesize wordLV;
@synthesize wordListType;
@synthesize searchBar;
@synthesize searchBarController;

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

- (void) setupSearchBar
{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, W([self view]), SEARCH_BAR_HEIGHT)];
    searchBarController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    [searchBarController setSearchResultsDataSource:self];
    [searchBarController setSearchResultsDelegate:self];
    [searchBar setDelegate:self];
    [[self view] addSubview:searchBar];
}

- (void) setupTableView
{
    wordLV = [[UITableView alloc] initWithFrame:CGRectMake(0,SEARCH_BAR_HEIGHT, W([self view]), H([self view])-TAB_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT-SEARCH_BAR_HEIGHT)];
    [wordLV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wordLV setDataSource:self];
    [wordLV setDelegate:self];
    [wordLV setSectionIndexBackgroundColor:[UIColor clearColor]];
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

#pragma Search Display Controller

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    isSearching = YES;
    NSLog(@"Inside This");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"Inside This");
    return NO;
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
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



@end
