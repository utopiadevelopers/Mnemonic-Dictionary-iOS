//
//  SplashViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 04/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:UIColorFromRGB(UTOPIA_BLUE)];
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(presentViewController:) userInfo:nil repeats:NO];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) presentViewController:(NSTimer*) timer
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGGED_IN])
    {
        if([[NSUserDefaults standardUserDefaults] boolForKey:IS_JSON_DOWNLOADED])
        {
            [self presentViewController:[CommonFunction getDashboardViewController] animated:YES completion:^{}];
        }
        else
        {
            [self presentViewController:[CommonFunction getDownloadViewController] animated:YES completion:^{}];
        }
    }
    else
    {
        [self presentViewController:[CommonFunction getLoginViewController] animated:YES completion:^{}];
    }
}

@end
