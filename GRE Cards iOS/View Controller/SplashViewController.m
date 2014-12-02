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
    
    UIButton *signUpButton;
    UIButton *loginButton;
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
    app_name = [[UILabel alloc] init];
    
    signUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //Logo
    [logo setFont:FONT_ICON(220)];
    [logo setTextAlignment:NSTextAlignmentLeft];
    [logo setTextColor:[UIColor whiteColor]];
    [logo setText:FONT_ICON_BOOK_2];
    [logo sizeToFit];
    
    //App_Name
    [app_name setFont:FONT_VERY_BIG_BOLD];
    [app_name setText:NSLocalizedString(@"APP_NAME", nil)];
    [app_name setNumberOfLines:1];
    [app_name sizeToFit];
    [app_name setTextColor:[UIColor whiteColor]];
    
    //Login Button
    [loginButton setTitle:NSLocalizedString(@"LOGIN", nil) forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedString(@"LOGIN", nil) forState:UIControlStateHighlighted];
    [loginButton setHidden:YES];

    // Signup
    [signUpButton setTitle:NSLocalizedString(@"SIGNUP", nil) forState:UIControlStateNormal];
    [signUpButton setTitle:NSLocalizedString(@"SIGNUP", nil) forState:UIControlStateHighlighted];
    [signUpButton setHidden:YES];
    
    [[self view] addSubview:logo];
    [[self view] addSubview:app_name];
    [[self view] addSubview:signUpButton];
    [[self view] addSubview:loginButton];
}

#pragma View Functions

-(void) viewDidLayoutSubviews
{
    [logo setCenter:[[self view] center]];
    [logo setFrame:CGRectMake(X(logo), Y(logo)-1*SIDE_PADDING,W(logo),H(logo)-2*SIDE_PADDING)];
    [app_name setCenter:CGPointMake(CENTER_X(logo), BOTTOM(logo)+H(app_name)/2)];
    
    [signUpButton setFrame:CGRectMake(2*SIDE_PADDING, BOTTOM(app_name), W([self view])-4*SIDE_PADDING, BUTTON_HEIGHT)];
    [loginButton setFrame:CGRectMake(2*SIDE_PADDING, BOTTOM(signUpButton)+SIDE_PADDING/2, W([self view])-4*SIDE_PADDING, BUTTON_HEIGHT)];
    
    [signUpButton setBackgroundColor:[UIColor cyanColor]];
    [loginButton setBackgroundColor:[UIColor greenColor]];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:UIColorFromRGB(UTOPIA_BLUE)];
}

- (void) viewDidAppear:(BOOL)animated
{
    if([CommonFunction isUserLoggedIn])
    {
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(presentViewController:) userInfo:nil repeats:NO];
    }
    else
    {
        [self showLoginViews];
    }
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) presentViewController:(NSTimer*) timer
{
    [self presentViewController:[CommonFunction getDashboardViewController] animated:YES completion:^{}];
}

#pragma Login Animations 

-(void) showLoginViews
{
    [loginButton setHidden:NO];
    [signUpButton setHidden:NO];
}

@end

