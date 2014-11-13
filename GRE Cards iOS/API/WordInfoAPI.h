//
//  WordInfoAPI.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 12/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "UtopiaObject.h"
#import "WordObject.h"

@protocol WordInfoDelegateAPI <NSObject>

@required
-(void) wordFetchedSuccesfully;

@required
-(void) wordFetchingFailed;

@end

@interface WordInfoAPI : UtopiaObject<APIManagerDelegate>

@property (nonatomic, strong) WordObject *wordObj;
@property (nonatomic) id<WordInfoDelegateAPI> delegate;

-(void) fetchWordWithWordID:(NSString*)wordID;

@end
