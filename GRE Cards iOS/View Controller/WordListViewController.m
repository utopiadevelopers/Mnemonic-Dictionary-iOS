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
    return @"A";
}

@end
