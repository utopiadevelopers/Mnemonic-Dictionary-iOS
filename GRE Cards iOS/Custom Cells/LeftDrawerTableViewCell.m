//
//  LeftDrawerTableViewCell.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 01/12/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "LeftDrawerTableViewCell.h"

#define ICON_SIZE 25.0f

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
    [self setBackgroundColor:[UIColor clearColor]];
    
    labelIcon = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING, 0, ICON_SIZE, LEFT_DRAWER_CELL_HEIGHT)];
    [labelIcon setFont:FONT_ICON(14)];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(AFTER(labelIcon)+SIDE_PADDING/2, Y(labelIcon), W([self contentView]) - ICON_SIZE - SIDE_PADDING, LEFT_DRAWER_CELL_HEIGHT)];
    [labelName setTextColor:[UIColor whiteColor]];
    [labelName setFont:FONT_BODY_BOLD];
    
    [[self contentView] addSubview:labelIcon];
    [[self contentView] addSubview:labelName];
}

-(void) updateCellWithName:(NSString*) name andIcon:(NSString*) icon
{
    [labelIcon setText:icon];
    [labelName setText:name];
}

@end
