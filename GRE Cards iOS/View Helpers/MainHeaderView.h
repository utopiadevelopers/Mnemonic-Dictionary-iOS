//
//  MainHeaderView.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 03/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeaderView : UIView

@property (weak, nonatomic) id parentVC;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIBarButtonItem *barBackButton;

/**
 * This method is used to create the header view in all view controllers that are pushed into the stack.
 * It returns a UIView that can be added to the main view.
 */
- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext subtitleText:(NSString *)subtitleText backButtonRequired:(BOOL)backButtonRequired extraButtonRequired:(BOOL)extraButtonRequired;
- (void)centerAlignTitle;
+ (void)popVC:(id)vc;


@end
