//
//  DashboardViewController.h
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import <UIKit/UIKit.h>
#import "WordListViewController.h"


@interface DashboardViewController : UIViewController

@property (nonatomic,weak) UIViewController *wordList;
@property (nonatomic,weak) UIViewController *favList;
@property (nonatomic,weak) UIViewController *ignoreList;


@end
