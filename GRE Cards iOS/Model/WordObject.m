//
//  WordObject.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 30/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "WordObject.h"

@implementation WordObject

@synthesize wordID;
@synthesize word;
@synthesize definition_short;
@synthesize defintion_arr;
@synthesize mnemonics_arr;
@synthesize isFav;
@synthesize isComplete;

-(id) init
{
    self = [super init];
    if (self)
    {
        [self setWord:@""];
        [self setWordID:@""];
        [self setDefinition_short:@""];
        [self setDefintion_arr:[[NSMutableArray alloc] init]];
        [self setMnemonics_arr:[[NSMutableArray alloc] init]];
        [self setIsComplete:NO];
        [self setIsFav:NO];        
    }
    return self;
}

-(NSString*) description
{
    NSString *line   = [NSString stringWithFormat:@"---------------------------------"];
    
    return [NSString stringWithFormat:@"\n%@\nWord :%@(%@)\nShort Def:%@%@%@\n%@\n",line,word,wordID,definition_short,[self defintion_arr_description],[self mnemonics_arr_description],line];
}

-(NSString*) defintion_arr_description
{
    NSString *result = [[NSString alloc] init];
    for (DefinitionObject *obj in defintion_arr)
    {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"\n\nDefinition : %@\nSynonyms : %@\nExample Sentence",obj.def,[obj.syn componentsJoinedByString:@","]]];
        
        for (NSString *sentence in obj.sent)
        {
            result = [result stringByAppendingString:[NSString stringWithFormat:@"\n  -->%@",sentence]];
        }
    }
    return result;
}

-(NSString*) mnemonics_arr_description
{
    NSString *result = [NSString stringWithFormat:@"\n\nMnemonics (Memory Aids) for %@",word];
    
    for (NSString *mnemonic in mnemonics_arr)
    {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"\n%@",mnemonic]];
    }
    
    return result;
}

@end
