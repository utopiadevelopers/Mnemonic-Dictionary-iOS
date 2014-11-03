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
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIBarButtonItem *barBackButton;

- (id)initMainHeaderWithParent:(id)parent WithTitle:(NSString *)titletext backButtonRequired:(BOOL)backButtonRequired;
- (void)centerAlignTitle;
+ (void)popVC:(id)vc;


@end
