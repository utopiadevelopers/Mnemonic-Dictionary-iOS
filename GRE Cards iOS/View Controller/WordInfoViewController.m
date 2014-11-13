//
//  WordInfoViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 11/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordInfoViewController.h"
#import "MainHeaderView.h"

@interface WordInfoViewController ()

@end

@implementation WordInfoViewController
{
    WordInfoAPI *wordAPI;
    UIActivityIndicatorView *activityIndicator;
    UIView *activityIndicatorView;
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
}

- (void) setupViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma Word Info Delegates

- (void) wordFetchedSuccesfully
{
    [activityIndicator stopAnimating];
}

- (void) wordFetchingFailed
{
    
}

@end
