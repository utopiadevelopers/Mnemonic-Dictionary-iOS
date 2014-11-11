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

@synthesize wordObj;

- (id) initWithWord:(WordObject*) word
{
    self = [super init];
    if(self)
    {
        [self setWordObj:word];
        [self setupNavigationBar];
    }
    return self;
}

- (void) setupNavigationBar
{
    MainHeaderView *headerView = [[MainHeaderView alloc] initMainHeaderWithParent:self WithTitle:[wordObj word] backButtonRequired:YES];
    UIBarButtonItem *leftLabelButton = [[UIBarButtonItem alloc] initWithCustomView:headerView];
    [[self navigationItem] setLeftBarButtonItem:leftLabelButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void) setupViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

@end
