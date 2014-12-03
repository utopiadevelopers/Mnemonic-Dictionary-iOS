//
//  LeftDrawerTableViewCell.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 01/12/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LEFT_DRAWER_CELL_HEIGHT 45.0f

@interface LeftDrawerTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *labelName;
@property (nonatomic, strong) IBOutlet UILabel *labelIcon;

-(void) updateCellWithName:(NSString*) name andIcon:(NSString*) icon;

@end
