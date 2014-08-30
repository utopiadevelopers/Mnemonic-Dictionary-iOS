//
//  DefinitionObject.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 30/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefinitionObject : NSObject

@property (nonatomic,strong) NSString *def;
@property (nonatomic,strong) NSMutableArray *sent;
@property (nonatomic,strong) NSMutableArray *syn;

@end
