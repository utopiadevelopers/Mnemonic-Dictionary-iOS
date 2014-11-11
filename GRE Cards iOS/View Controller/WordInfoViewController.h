//
//  WordInfoViewController.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 11/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordInfoViewController : UIViewController

@property (strong,nonatomic) WordObject *wordObj;

- (id) initWithWord:(WordObject*) word;

@end
