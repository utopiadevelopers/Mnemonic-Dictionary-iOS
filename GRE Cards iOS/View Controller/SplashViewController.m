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

- (id) init
{
    self = [self init];
    if(self)
    {
        
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) presentViewController
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
