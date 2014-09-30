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
    NSString *Alphabets;
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
        Alphabets = @"ABCDEFGHIJKLMONPQRSTUVWXYZ";
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
    NSString *lowerAplha = [[NSString stringWithString:Alphabets] lowercaseString];
    for (WordObject *word in wordList)
    {
        for (int i=0; i<[lowerAplha length]; i++)
        {
            NSString *l_str = [[lowerAplha substringFromIndex:i] substringToIndex:1];
            NSString *w_str = [[[word word] substringFromIndex:0] substringToIndex:1];
            
            if([l_str isEqualToString:w_str])
            {
                NSMutableArray * array = [sectionWordList objectForKey:l_str];
                if (array==nil)
                {
                    array = [[NSMutableArray alloc] init];
                }
                [array addObject:word];
                [sectionWordList setObject:array forKey:l_str];
                break;
            }
        }
    }
}

#pragma Search

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

//- (void)textFieldDidChange:(UITextField *) textField {
//    if (textField == cuisinesSearchField) {
//        if([[textField text] length]>2) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                [sectionWordList removeAllObjects];
//                [wordList removeAllObjects];
//                [cuisineDict removeAllObjects];
//                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name contains[c] %@",[textField text]];
//                filteredArray = [NSMutableArray arrayWithArray:[dbArray filteredArrayUsingPredicate:predicate]];
//                if([filteredArray count]>0) {
//                    if([previousSelectedCuisines count]>0) {
//                        [self updateFilteredArray];
//                    }
//                    [self createCuisineDict];
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [cuisinesTableView reloadData];
//                });
//            });
//        }
//        else {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                [filteredArray removeAllObjects];
//                [sectionHeading removeAllObjects];
//                [cuisineDict removeAllObjects];
//                if([previousSelectedCuisines count]>0) {
//                    [self updateDBArray];
//                }
//                else {
//                    [filteredArray addObjectsFromArray:dbArray];
//                }
//                [self createCuisineDict];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [cuisinesTableView reloadData];
//                });
//            });
//            
//        }
//    }
//}


#pragma TableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *lowerAplha = [[NSString stringWithString:Alphabets] lowercaseString];
    NSString *l_str = [[lowerAplha substringFromIndex:indexPath.section] substringToIndex:1];
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
    NSString *lowerAplha = [[NSString stringWithString:Alphabets] lowercaseString];
    NSString *l_str = [[lowerAplha substringFromIndex:section] substringToIndex:1];
    
    return [[sectionWordList objectForKey:l_str] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[Alphabets substringFromIndex:section] substringToIndex:1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (int i=0; i<[Alphabets length]; i++)
    {
        NSString *l_str = [[Alphabets substringFromIndex:i] substringToIndex:1];
        [array addObject:l_str];
    }
    return array;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [wordLV deselectRowAtIndexPath:indexPath animated:NO];
    WordListTableViewCell *cell = (WordListTableViewCell*)[wordLV cellForRowAtIndexPath:indexPath];
    [cell toggleFav];
}



@end
