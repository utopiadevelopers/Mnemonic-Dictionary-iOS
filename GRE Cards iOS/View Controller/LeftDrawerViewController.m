//
//  LeftDrawerViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 28/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "LeftDrawerViewController.h"
#import "LeftDrawerTableViewCell.h"

#define SECTION_WORDLISTSELECTION 0
#define SECTION_SETTINGS          1

@interface LeftDrawerViewController ()
{
    UITableView *settingsTableView;
}
@end

@implementation LeftDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor grayColor]];
    [self setupTableView];
}

#pragma View Functions

-(void) setupTableView
{
    settingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT_ADDITION,LEFT_DRAWER_WIDTH, H([self view]))];
    [settingsTableView setDelegate:self];
    [settingsTableView setDataSource:self];
    [settingsTableView setBackgroundColor:[UIColor clearColor]];
    [settingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[self view] addSubview:settingsTableView];
}

#pragma Table View Functions

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"LeftDrawerCell";
    
    LeftDrawerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
        cell = [[LeftDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    switch ([indexPath section])
    {
        case SECTION_WORDLISTSELECTION:
            
            break;
            
        case SECTION_SETTINGS:
            
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == SECTION_WORDLISTSELECTION)
    {
        return 0;
    }
    else if(section == SECTION_SETTINGS)
    {
        return 0;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == SECTION_WORDLISTSELECTION)
    {
        return NSLocalizedString(@"WORD_LIST_SELECTION", nil);
    }
    else if(section == SECTION_SETTINGS)
    {
        return NSLocalizedString(@"SETTINGS", nil);
    }
    return NSLocalizedString(@"", nil);
}
@end
