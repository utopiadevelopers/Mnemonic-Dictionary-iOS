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
    wordLabel = [[UILabel alloc] init];
    
    [wordLabel setFrame:CGRectMake(0, 0,W(self.contentView),H(self.contentView))];
    
    [self.contentView addSubview:wordLabel];
}

- (void) updateWord:(WordObject*) word
{
    wordObj = word;
    
    [wordLabel setText:[word word]];
}

@end
