//
//  DashboardViewController.h
//  Gre Cards
//
//  Created by Satyam Krishna on 27/07/14.
//

#import <UIKit/UIKit.h>


@interface DashboardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIToolbar *actionBar;
@property (nonatomic, strong) IBOutlet UITableView *wordLV;

@end
