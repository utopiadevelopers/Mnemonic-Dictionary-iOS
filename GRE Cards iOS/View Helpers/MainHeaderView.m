//
//  MainHeaderView.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 03/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "MainHeaderView.h"

@interface MainHeaderView()
{
    BOOL backButtonSpaceRequired;
}
@end

@implementation MainHeaderView

@synthesize parentVC;
@synthesize titleLabel;
@synthesize backButton;
@synthesize barBackButton;


- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext backButtonRequired:(BOOL)backButtonRequired
{
    [self setParentVC:parent];    
    self = [self initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], MAIN_HEADER_HEIGHT)];
    [self setBackgroundColor:[UIColor greenColor]];
    backButtonSpaceRequired = backButtonRequired;

    
    if(backButtonRequired)
    {
        backButton = [[UIButton alloc] init];
        //[UIButton getHeaderButtonWithInsets:UIEdgeInsetsMake(10, -15, 0, 15)];
        [backButton setBackgroundColor:[UIColor clearColor]];
        [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
        //[backButton setImage:UIIcon_Z9(@"misc_backarrowwhite.png") forState:UIControlStateNormal];
        [backButton setTintColor:[UIColor whiteColor]];
//        barBackButton = [[UIBarButtonItem alloc] initWithImage:UIIcon_Z9(@"misc_backarrowwhite.png") style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
//        [barBackButton setTintColor:[UIColor whiteColor]];
//        [barBackButton setBackgroundImage:[CommonFunction imageWithColor:[UIColor ZomatoRedColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barBackButton setBackgroundImage:[CommonFunction imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    
    if(titletext != nil)
    {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setFont:FONT_NAV_BAR_LABEL];
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
    CGFloat titleX = 5;
    
    if (backButton != nil)
    {
        ((UIViewController *)parentVC).navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
    
    if (titleLabel != nil)
    {
        [titleLabel setFrame:CGRectMake(titleX, 0, titleWidth - titleX, H(self))];
        [titleLabel setFrame:CGRectMake(0, 0, titleWidth, H(self))];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setBackgroundColor:[UIColor cyanColor]];
    }
    
    [self addSubview:titleLabel];
}

- (void)backPressed
{
    
    [((UIViewController *)parentVC).navigationController popViewControllerAnimated:YES];
}

+ (void)popVC:(id)vc
{
    if(((UIViewController *)vc).isViewLoaded)
    {
        [((UIViewController *)vc).navigationController popViewControllerAnimated:YES];
    }
}

- (void) centerAlignTitle
{
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end
