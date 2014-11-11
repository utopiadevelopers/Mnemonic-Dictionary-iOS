//
//  WordInfoViewController.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 11/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordInfoViewController.h"

@interface WordInfoViewController ()

@end

@implementation WordInfoViewController

@synthesize wordID;

- (id) initWithWordID:(NSString*) word
{
    self = [super init];
    if(self)
    {
        [self setWordID:word];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void) setupViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

@end
