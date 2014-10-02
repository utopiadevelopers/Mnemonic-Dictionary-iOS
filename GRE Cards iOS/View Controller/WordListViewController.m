//
//  WordListViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordListViewController.h"

@interface WordListViewController ()
{
    NSMutableArray* wordList;
    NSMutableArray* searchResults;
    NSMutableArray* dbArray;
    NSMutableArray* sectionHeading;
    NSMutableDictionary *sectionWordList;
}
@end

@implementation WordListViewController

@synthesize actionBar;
@synthesize wordLV;
@synthesize wordListType;
@synthesize searchBar;

-(id) initWithWordListType:(WordListType) listType
{
    self = [super init];
    if(self)
    {
        wordListType = listType;
        sectionWordList = [[NSMutableDictionary alloc] init];
        sectionHeading  = [[NSMutableArray alloc] init];
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
    
    }
    else if(wordListType == WordListTypeFav)
    {
    
    }
    else
    {
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupSearchBar
{
    searchBar = [[UISearchBar alloc] init];
    [searchBar setFrame:CGRectMake(0,STATUS_BAR_HEIGHT_ADDITION, W([self view]),40)];
    [searchBar setDelegate:self];
    [[self view] addSubview:searchBar];
}

- (void) setupTableView
{
    wordList = [[DBManager sharedDBManager] getWordList];
    [self setupMutuableDic];
    wordLV = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT_ADDITION+H(searchBar), W(self.view), H(self.view)-TAB_BAR_HEIGHT-STATUS_BAR_HEIGHT_ADDITION-H(searchBar))];
    [wordLV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wordLV setDataSource:self];
    [wordLV setDelegate:self];
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

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"word contains[c] %@", searchText];
    searchResults = [wordList filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma TableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *l_str = [sectionHeading objectAtIndex:indexPath.section];
    NSMutableArray *list = [sectionWordList objectForKey:l_str];
    WordObject* wordObj = [list objectAtIndex:indexPath.row];
    
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
    return [sectionWordList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WordListTableViewCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sectionWordList objectForKey:[sectionHeading objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionHeading objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionHeading;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [wordLV deselectRowAtIndexPath:indexPath animated:NO];
    WordListTableViewCell *cell = (WordListTableViewCell*)[wordLV cellForRowAtIndexPath:indexPath];
    [cell toggleFav];
}



@end
