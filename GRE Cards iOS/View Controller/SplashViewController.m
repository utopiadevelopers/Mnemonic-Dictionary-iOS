//
//  SplashViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 04/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "SplashViewController.h"

#define LOGO_HEIGHT 300.0f

@interface SplashViewController ()
{
    UILabel *logo;
    UILabel *app_name;
}
@end

@implementation SplashViewController

-(id) init
{
    self = [super init];
    if(self)
    {
        [self setupViews];
    }
    return self;
}

-(void) setupViews
{
    logo = [[UILabel alloc] init];
    [logo setFont:FONT_ICON(220)];
    [logo setTextAlignment:NSTextAlignmentLeft];
    [logo setTextColor:[UIColor whiteColor]];
    [logo setNumberOfLines:1];
    [logo setText:FONT_ICON_BOOK_2];
    [logo sizeToFit];
    [[self view] addSubview:logo];
    
    app_name = [[UILabel alloc] init];
    [app_name setFont:FONT_BODY_BOLD];
}

#pragma View Functions

-(void) viewDidLayoutSubviews
{
    [logo setCenter:[[self view] center]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:UIColorFromRGB(UTOPIA_BLUE)];
}

- (void) viewDidAppear:(BOOL)animated
{
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(presentViewController:) userInfo:nil repeats:NO];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) presentViewController:(NSTimer*) timer
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGGED_IN])
    {
        [self presentViewController:[CommonFunction getDashboardViewController] animated:YES completion:^{}];
    }
    else
    {
        [self presentViewController:[CommonFunction getLoginViewController] animated:YES completion:^{}];
    }
}

@end
