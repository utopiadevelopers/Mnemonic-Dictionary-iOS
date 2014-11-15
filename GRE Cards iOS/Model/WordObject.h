//
//  WordObject.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 30/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefinitionObject.h"

@interface WordObject : NSObject

@property (nonatomic,strong) NSString *word;
@property (nonatomic,strong) NSString *wordID;
@property (nonatomic,strong) NSString *definition_short;
@property (nonatomic,strong) NSMutableArray *mnemonics_arr;
@property (nonatomic,strong) NSMutableArray *defintion_arr;

@property (nonatomic) BOOL isFav;
@property (nonatomic) BOOL isComplete;

@end
