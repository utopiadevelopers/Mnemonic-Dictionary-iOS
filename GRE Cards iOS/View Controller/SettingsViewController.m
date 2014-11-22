//
//  SettingsViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 22/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(id) init
{
    self = [super init];
    if(self)
    {
        [self initializeVariables];
        [self setupViews];
    }
    return self;
}

-(void) initializeVariables
{
    
}

-(void) setupViews
{
    [[self view] setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
