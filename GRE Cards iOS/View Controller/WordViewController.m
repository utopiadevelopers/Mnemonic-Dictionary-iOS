//
//  WordViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 28/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()

@end

@implementation WordViewController

@synthesize word;

- (id) initWithWord:(WordObject*) wordObj
{
    self = [super init];
    if(self)
    {
        [self setWord:wordObj];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
