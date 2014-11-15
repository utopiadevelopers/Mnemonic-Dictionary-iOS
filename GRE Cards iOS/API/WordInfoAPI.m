//
//  WordInfoAPI.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 12/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordInfoAPI.h"

@implementation WordInfoAPI

@synthesize delegate;
@synthesize wordObj;

-(id) init
{
    self = [super init];
    if(self)
    {
        [self setWordObj:[[WordObject alloc] init]];
    }
    return self;
}

-(void) fetchWordWithWordID:(NSString*)wordID
{
    [wordObj setWordID:wordID];
    [[APIManager sharedApiManager] getRequestForClass:[WordInfoAPI class] WithParameters:[self serializeObject] withDelegate:self];
}

#pragma API Manager

-(NSDictionary *) serializeObject
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[wordObj wordID] forKey:@"wordID"];
    [params addEntriesFromDictionary:[APIManager accessTokenDict]];
    return params;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    NSString *status = [responseObject objectForKey:@"message"];
    NSDictionary *word = [responseObject objectForKey:@"word"];
    
    if([status isEqualToString:STATUS_SUCCESS])
    {
        [wordObj setWord:[word objectForKey:@"word"]];
        [wordObj setDefinition_short:[word objectForKey:@"definition_short"]];
        [wordObj setMnemonics_arr:[word objectForKey:@"mnemonics_arr"]];
        
        for (NSMutableDictionary *data in [word objectForKey:@"defintion_arr"])
        {
            DefinitionObject *defObj = [[DefinitionObject alloc] init];
            [defObj setDef:[data objectForKey:@"def"]];
            [defObj setSyn:[data objectForKey:@"syn"]];
            [defObj setSent:[data objectForKey:@"sent"]];
            [[wordObj defintion_arr] addObject:defObj];
        }
    }
    else
    {
        [self didFailForClass:[WordInfoAPI class] withError:nil andParams:params];
    }
    
}

+ (NSString *)getAPIPath
{
    return [NSString stringWithFormat:@"%@/word_info.php",API_URL];
}

#pragma API Delegates

-(void) didFetchObjects:(id)objects ForClass:(Class)klass withParams:(NSDictionary *)params
{
    NSLog(@"%@",[wordObj description]);
    if([delegate respondsToSelector:@selector(wordFetchedSuccesfully)])
    {
        [wordObj setIsComplete:YES];
        [delegate wordFetchedSuccesfully];
    }
}

-(void) didFailForClass:(Class)klass withError:(NSError *)error andParams:(NSDictionary *)dictionary
{
    if([delegate respondsToSelector:@selector(wordFetchingFailed)])
    {
        [delegate wordFetchingFailed];
    }
}


@end
