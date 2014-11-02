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
    BOOL extraButtonSpaceRequired;
}
@end

@implementation MainHeaderView

@synthesize parentVC;
@synthesize titleLabel,subtitleLabel;
@synthesize backButton;
@synthesize barBackButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
    }
    return self;
}

- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext subtitleText:(NSString *)subtitleText backButtonRequired:(BOOL)backButtonRequired extraButtonRequired:(BOOL)extraButtonRequired
{
    parentVC = parent;

    CGFloat titleViewHeight = 64;
    
    self = [self initWithFrame:CGRectMake(0, 0, [CommonFunction getPhoneWidth], MAIN_HEADER_HEIGHT)];

    backButtonSpaceRequired = backButtonRequired;
    extraButtonSpaceRequired = extraButtonRequired;
    
//    if(backButtonRequired)
//    {
//        backButton = [UIButton getHeaderButtonWithInsets:UIEdgeInsetsMake(10, -15, 0, 15)];
//        [backButton setBackgroundColor:[UIColor clearColor]];
//        
//        [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
//        [backButton setImage:UIIcon_Z9(@"misc_backarrowwhite.png") forState:UIControlStateNormal];
//        //        [backButton setBackgroundColor:[UIColor ZDarkColor]];
//        [backButton setTintColor:[UIColor whiteColor]];
//        barBackButton = [[UIBarButtonItem alloc] initWithImage:UIIcon_Z9(@"misc_backarrowwhite.png") style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
//        [barBackButton setTintColor:[UIColor whiteColor]];
//        [barBackButton setBackgroundImage:[CommonFunction imageWithColor:[UIColor ZomatoRedColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barBackButton setBackgroundImage:[CommonFunction imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    }
    
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
    
    if(subtitleText != nil)
    {
        subtitleLabel = [[UILabel alloc] init];
        [subtitleLabel setBackgroundColor:[UIColor clearColor]];
        [subtitleLabel setTextAlignment:NSTextAlignmentCenter];
        [subtitleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [subtitleLabel setText:subtitleText];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat titleWidth = [CommonFunction getPhoneWidth]-95;
    CGFloat titleX = 5;
    
    if (backButton != nil)
    {
        ((UIViewController *)parentVC).navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]  initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]; //done to hide the native back button
    }
    
    
    if(extraButtonSpaceRequired)
        titleWidth = 225;
    
    if (titleLabel != nil)
    {
        if (subtitleLabel == nil)
        {
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))    //for iOS7
            {
                [titleLabel setFrame:CGRectMake(titleX, 0, titleWidth - titleX, H(self))];
                [titleLabel setFrame:CGRectMake(-5, 0, titleWidth, H(self))];
                [titleLabel setTextAlignment:NSTextAlignmentCenter];
            }
            else
            {
                [titleLabel setFrame:CGRectMake(0, 0, titleWidth, H(self))];  //for iOS6
            }
        }
        
        else
        {
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) //for iOS7
            {
                [titleLabel setFrame:CGRectMake(titleX, 8, titleWidth - titleX, H(self)/2)];
                [subtitleLabel setFrame:CGRectMake(X(titleLabel),  H(titleLabel) - 8 , titleWidth, H(titleLabel))];
            }
            else //for iOS6
            {
                [titleLabel setFrame:CGRectMake(0, 5, titleWidth, H(self)/2)];
                [subtitleLabel setFrame:CGRectMake(X(titleLabel),  H(titleLabel) , titleWidth, H(titleLabel) - 5)];
            }
            
            [self addSubview:subtitleLabel];
        }
        [self addSubview:titleLabel];
    }
}

- (void)backPressed
{
    [((UIViewController *)parentVC).navigationController popViewControllerAnimated:YES];
}

+ (void)popVC:(id)vc
{
    if(((UIViewController *)vc).isViewLoaded)
        [((UIViewController *)vc).navigationController popViewControllerAnimated:YES];
}

- (void)centerAlignTitle
{
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end
