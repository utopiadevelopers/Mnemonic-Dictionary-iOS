//
//  WordListViewController.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordListTableViewCell.h"

@interface WordListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

typedef NS_ENUM(NSInteger, WordListType)
{
    WordListTypeFull=1,
    WordListTypeFav,
    WordListTypeIgn
};

@property (nonatomic, weak) IBOutlet UIToolbar *actionBar;
@property (nonatomic, strong) IBOutlet UITableView *wordLV;
@property (nonatomic, assign) WordListType wordListType;

-(id) initWithWordListType:(WordListType) listType;
@end
