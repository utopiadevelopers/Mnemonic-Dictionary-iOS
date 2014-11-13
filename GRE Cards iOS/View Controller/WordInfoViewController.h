//
//  WordInfoViewController.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 11/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordInfoAPI.h"

@interface WordInfoViewController : UIViewController<WordInfoDelegateAPI>

@property (strong,nonatomic) WordObject *wordObj;

- (id) initWithWord:(WordObject*) word;

@end
