//
//  UtopiaObject.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 09/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtopiaObject : NSObject

- (void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params;

+ (NSString *) getAPIPath;

@end
