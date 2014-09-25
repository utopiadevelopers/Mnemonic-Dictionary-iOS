//
//  WordListViewController.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIToolbar *actionBar;
@property (nonatomic, strong) IBOutlet UITableView *wordLV;

@end
