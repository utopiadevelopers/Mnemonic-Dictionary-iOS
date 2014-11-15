//
//  WordInfoViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 11/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordInfoViewController.h"
#import "MainHeaderView.h"
#import <math.h>

@interface WordInfoViewController ()

@end

@implementation WordInfoViewController
{
    WordInfoAPI *wordAPI;
    UIActivityIndicatorView *activityIndicator;
    UIView *activityIndicatorView;
    
    // WordObj
    
    UILabel *mnemonicHeader;
    UILabel *shortDefinition;
    UIView *definitionView;
    NSMutableArray *mnemonicViewArray;
}

@synthesize wordObj;

- (id) initWithWord:(WordObject*) word
{
    self = [super init];
    if(self)
    {
        [self setWordObj:word];
        [self initalizeVariables];
        [self setupIndicatorView];
        [self setupNavigationBar];
    }
    return self;
}

#pragma init

- (void) initalizeVariables
{
    wordAPI = [[WordInfoAPI alloc] init];
    [wordAPI setDelegate:self];
}

- (void) setupNavigationBar
{
    MainHeaderView *headerView = [[MainHeaderView alloc] initMainHeaderWithParent:self WithTitle:[wordObj word] backButtonRequired:YES];
    
    UIBarButtonItem *leftLabelButton = [[UIBarButtonItem alloc] initWithCustomView:headerView];
    [[self navigationItem] setLeftBarButtonItem:leftLabelButton];
    
    UIBarButtonItem *rightLabelButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
    [[self navigationItem] setRightBarButtonItem:rightLabelButton];
    
}

- (void) setupIndicatorView
{
    activityIndicator = [[UIActivityIndicatorView alloc] init];
    [activityIndicator setHidesWhenStopped:YES];
    [activityIndicator stopAnimating];
    
    activityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, MAIN_HEADER_HEIGHT)];
    [activityIndicatorView setBackgroundColor:[UIColor clearColor]];
    [activityIndicator setCenter:[activityIndicatorView center]];
    [activityIndicatorView addSubview:activityIndicator];
    
    if(![wordObj isComplete])
    {
        [activityIndicator startAnimating];
        [wordAPI fetchWordWithWordID:[wordObj wordID]];
    }
}

#pragma Views Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self updateWordView];
}

- (void) setupViews
{
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    shortDefinition = [[UILabel alloc] initWithFrame:CGRectZero];
    definitionView  = [[UIView alloc] initWithFrame:CGRectZero];
    mnemonicHeader  = [[UILabel alloc] initWithFrame:CGRectZero];
    
    
    [shortDefinition setFont:FONT_BODY];
    [shortDefinition setTextColor:[UIColor blackColor]];
    [shortDefinition setNumberOfLines:0];
    [shortDefinition sizeToFit];
    
    
    [[self view] addSubview:shortDefinition];
    [[self view] addSubview:definitionView];
    [[self view] addSubview:mnemonicHeader];
}

- (void) viewDidLayoutSubviews
{
    if([wordObj isComplete])
    {
        CGRect shortDefinitionRect = [[shortDefinition text] boundingRectWithSize:CGSizeMake((W([self view])-SIDE_PADDING), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[shortDefinition font]} context:nil];
        [shortDefinition setFrame:CGRectMake(SIDE_PADDING/2, SIDE_PADDING/2,shortDefinitionRect.size.width,shortDefinitionRect.size.height)];
    }
}

- (void) updateWordView
{
    [shortDefinition setAttributedText:[self getShortDefinitionAttributedString]];
}

- (NSMutableAttributedString*) getShortDefinitionAttributedString
{
    NSString *definition_header = @"Short Definition : ";
    
    NSMutableAttributedString *definition_short = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",definition_header,[wordObj definition_short]]];
    
    [definition_short addAttribute:NSFontAttributeName value:FONT_BODY_BOLD range:NSMakeRange(0, [definition_header length])];
    [definition_short addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [definition_header length])];

    return definition_short;
}

#pragma Word Info Delegates

- (void) wordFetchedSuccesfully
{
    [activityIndicator stopAnimating];
    [self setWordObj:[wordAPI wordObj]];
    [self viewDidLayoutSubviews];
    [self updateWordView];
}

- (void) wordFetchingFailed
{
    
}

@end
