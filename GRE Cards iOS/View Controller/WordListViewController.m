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
    [self setupTableView];
}

- (void) initVariables
{
    if (wordListType == WordListTypeFull)
    {
        [[self tabBarItem] setTitle:@"Word List"];
        [[self tabBarItem] setSelectedImage:IMG(@"tab_list.png")];
    }
    else if(wordListType == WordListTypeFav)
    {
        [[self tabBarItem] setTitle:@"Favorites"];
        [[self tabBarItem] setSelectedImage:IMG(@"tab_fav.png")];
    }
    else
    {
        [[self tabBarItem] setTitle:@"Ignores"];
        [[self tabBarItem] setSelectedImage:IMG(@"tab_ign.png")];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupTableView
{
    wordList = [[DBManager sharedDBManager] getWordList];
    [self setupMutuableDic];
    wordLV = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT_ADDITION, W(self.view), H(self.view)-TAB_BAR_HEIGHT-STATUS_BAR_HEIGHT_ADDITION)];
    [wordLV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wordLV setDataSource:self];
    [wordLV setDelegate:self];
    [self.view addSubview:wordLV];
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

#pragma TableView Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *lowerAplha = [[NSString stringWithString:Alphabets] lowercaseString];
    NSString *l_str = [[lowerAplha substringFromIndex:indexPath.section] substringToIndex:1];
    NSMutableArray *list = [sectionWordList objectForKey:l_str];
    WordObject* wordObj = [list objectAtIndex:indexPath.row];
    
    WordListTableViewCell *cell = (WordListTableViewCell *)[wordLV dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[WordListTableViewCell alloc] init];
        [cell updateWord:wordObj];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionWordList count];
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

@end
