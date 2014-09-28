//
//  WordListTableViewCell.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordObject.h"

@interface WordListTableViewCell : UITableViewCell

@property (nonatomic, strong) WordObject *wordObj;
@property (nonatomic, strong) IBOutlet UILabel *wordLabel;

- (void) updateWord:(WordObject*) word;

@end
