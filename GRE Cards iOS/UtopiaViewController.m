//
//  UtopiaViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 30/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "UtopiaViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface UtopiaViewController ()

@end

@implementation UtopiaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationDrawer];
}

-(void) setupNavigationDrawer
{
    // Open Drawer
    self.mm_drawerController.openDrawerGestureModeMask ^= MMOpenDrawerGestureModePanningNavigationBar;
    self.mm_drawerController.openDrawerGestureModeMask ^=  MMOpenDrawerGestureModePanningCenterView;
    
    // Close Drawer
    
    self.mm_drawerController.closeDrawerGestureModeMask ^= MMCloseDrawerGestureModePanningNavigationBar;
    self.mm_drawerController.closeDrawerGestureModeMask ^= MMCloseDrawerGestureModePanningCenterView;
    
    // Maximum Width
    
    [self.mm_drawerController setMaximumLeftDrawerWidth:LEFT_DRAWER_WIDTH];
}

-(void) sneakPeak
{
    [[self mm_drawerController] bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void) toggleDrawer
{
    [[self mm_drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
