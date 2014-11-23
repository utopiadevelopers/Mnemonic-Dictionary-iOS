//
//  MainHeaderView.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 03/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "MainHeaderView.h"
#import "WordInfoViewController.h"

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
    CGFloat titleX = 40;
    
    if (backButton != nil)
    {
        
        UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [[((UIViewController *) parentVC) navigationItem] setBackBarButtonItem:backBarButton];

    }
    
    if (titleLabel != nil)
    {
        [titleLabel setFrame:CGRectMake(titleX, 0, titleWidth - titleX, H(self))];
        [titleLabel setFrame:CGRectMake(0, 0, titleWidth, H(self))];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    
    [self addSubview:titleLabel];
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
