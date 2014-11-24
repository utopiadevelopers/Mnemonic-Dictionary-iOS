//
//  MainHeaderView.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 03/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "MainHeaderView.h"
#import "WordInfoViewController.h"

#define BACK_BUTTON_WIDTH 20.0f

@interface MainHeaderView()

@end

@implementation MainHeaderView

@synthesize parentVC;
@synthesize titleLabel;
@synthesize backButton;
@synthesize barBackButton;


- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext backButtonRequired:(BOOL)backButtonRequired
{
    [self setParentVC:parent];
    
    if([parent isKindOfClass:[WordInfoViewController class]])
    {
        self = [self initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth]-50, MAIN_HEADER_HEIGHT)];
    }
    else
    {
        self = [self initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], MAIN_HEADER_HEIGHT)];
    }
    
    if(backButtonRequired)
    {
        backButton = [[UIButton alloc] init];
        [backButton setBackgroundColor:[UIColor clearColor]];
        [backButton setBackgroundImage:IMG(@"backarrow") forState:UIControlStateNormal];
        [backButton setBackgroundImage:IMG(@"backarrow") forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTintColor:[UIColor whiteColor]];
    }
    
    if(titletext != nil)
    {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setFont:FONT_GOTHAM_BOLD(18)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [titleLabel setTextColor:UIColorFromRGB(NAV_BAR_ITEMS_COLOR)];
        [titleLabel setText:titletext];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat titleWidth = [CommonFunction getPhoneWidth];
    CGFloat titleX = SIDE_PADDING/2;
    
    if (backButton != nil)
    {
        [backButton setFrame:CGRectMake(0, 12.5, BACK_BUTTON_WIDTH,20)];
        [[((UIViewController *) parentVC) navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]]; //done to hide the native back button
        titleX = BACK_BUTTON_WIDTH+SIDE_PADDING/3;

    }
    
    if (titleLabel != nil)
    {
        [titleLabel setFrame:CGRectMake(titleX, 0, titleWidth - titleX, H(self))];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    
    [self addSubview:titleLabel];
    [self addSubview:backButton];
}

- (void)backPressed
{
    [[((UIViewController *)parentVC) navigationController] popViewControllerAnimated:YES];
}

+ (void)popVC:(id)vc
{
    if([((UIViewController *)vc) isViewLoaded])
    {
        [[((UIViewController *)vc) navigationController] popViewControllerAnimated:YES];
    }
}

- (void) centerAlignTitle
{
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end
