//
//  SocialLoginAPI.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 10/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SocialLoginDelegateAPI <NSObject>

@required
-(void) socialLoginWasSuccessful;

@required
-(void) socialLoginFalied;

@end

@interface SocialLoginAPI : UtopiaObject<APIManagerDelegate>

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *social_type;

@property (nonatomic) id<SocialLoginDelegateAPI>delegate;

-(void) socialLoginWithAccessToken:(NSString *)accessToken andType:(NSString *)type;

@end