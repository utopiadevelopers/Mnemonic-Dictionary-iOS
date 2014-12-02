//
//  LeftDrawerTableViewCell.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 01/12/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "LeftDrawerTableViewCell.h"

#define ICON_SIZE 40.0f

@implementation LeftDrawerTableViewCell

@synthesize labelName;
@synthesize labelIcon;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setupCell];
    }
    return self;
}

-(void) setupCell
{
    labelIcon = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING, 0, ICON_SIZE, 0)];
    [labelIcon setFont:FONT_ICON(14)];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(AFTER(labelIcon)+SIDE_PADDING/2, Y(labelIcon), W([self contentView]) - ICON_SIZE - SIDE_PADDING, 0)];
    [labelName setFont:FONT_HELVETICANEUE_LIGHT(15)];
    
}

-(void) updateCellWithName:(NSString*) name andIcon:(NSString*) icon
{
    [labelIcon setText:icon];
    [labelName setText:name];
}

@end
