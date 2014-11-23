//
//  WordListTableViewCell.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 24/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordListTableViewCell.h"

@implementation WordListTableViewCell

@synthesize wordObj;
@synthesize wordLabel;
@synthesize shortDefLabel;
@synthesize favView;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setupWord];
    }
    return self;
}

-(void) setupWord
{
    wordLabel     = [[UILabel alloc] init];
    shortDefLabel = [[UILabel alloc] init];
    
    favView = [[UIButton alloc] init];
    [favView setBackgroundImage:IMG(@"star_unselect.png") forState:UIControlStateNormal];
    [favView addTarget:self action:@selector(toggleFav) forControlEvents:UIControlEventTouchDown];
    
    [favView setFrame:CGRectMake(W(self.contentView)-1.60*SIDE_PADDING-20, SIDE_PADDING, 20, 20)];
    [wordLabel setFrame:CGRectMake(SIDE_PADDING,SIDE_PADDING/2,W(self.contentView)-2*SIDE_PADDING-W(favView),20)];
    [shortDefLabel setFrame:CGRectMake(SIDE_PADDING, SIDE_PADDING/2+BOTTOM(wordLabel),W(self.contentView)-2*SIDE_PADDING-W(favView),20)];
    
    [self.contentView addSubview:wordLabel];
    [self.contentView addSubview:shortDefLabel];
    [self.contentView addSubview:favView];
}

- (void) updateWord:(WordObject*) word
{
    wordObj = word;
    
    [wordLabel setText:[word word]];
    [shortDefLabel setText:[word definition_short]];
    
    
    [wordLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:18]];
    [shortDefLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:13]];
 
    [self updateFav];
}

- (void) updateFav
{
    if([wordObj isFav])
    {
        [favView setBackgroundImage:IMG(@"star_select.png") forState:UIControlStateNormal];
    }
    else
    {
        [favView setBackgroundImage:IMG(@"star_unselect.png") forState:UIControlStateNormal];
    }
}

- (void) toggleFav
{
    if([wordObj isFav])
    {
        [wordObj setIsFav:FALSE];
        [favView setBackgroundImage:IMG(@"star_unselect.png") forState:UIControlStateNormal];
    }
    else
    {
        [wordObj setIsFav:TRUE];
        [favView setBackgroundImage:IMG(@"star_select.png") forState:UIControlStateNormal];
    }
}

+ (float) cellHeight
{
    return SIDE_PADDING *3/2+ 40;
}

@end
