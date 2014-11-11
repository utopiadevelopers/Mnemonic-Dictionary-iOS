//
//  SocialLoginAPI.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 10/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "SocialLoginAPI.h"

@implementation SocialLoginAPI

@synthesize access_token;
@synthesize social_type;
@synthesize delegate;

-(void) socialLoginWithAccessToken:(NSString *)accessToken andType:(NSString *)type
{
    [self setAccess_token:accessToken];
    [self setSocial_type:type];
    [[APIManager sharedApiManager] getRequestForClass:[SocialLoginAPI class] WithParameters:[self serializeObject] withDelegate:self];
}

#pragma API Manager

-(NSDictionary *) serializeObject
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:access_token forKey:@"access_token"];
    [params setValue:social_type forKey:@"social_type"];
    return params;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    NSString *auth = [responseObject objectForKey:@"auth"];
    NSString *login = [responseObject objectForKey:@"login"];
    NSString *email = [responseObject objectForKey:@"email"];
    
    
    if([login isEqualToString:LOGIN_SUCCESS])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGGED_IN];
        [[NSUserDefaults standardUserDefaults] setValue:auth forKey:AUTH_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:LOGIN_NORMAL forKey:LOGIN_TYPE];
        
        if([delegate respondsToSelector:@selector(socialLoginWasSuccessful)])
        {
            [delegate socialLoginWasSuccessful];
        }
    }
    else
    {
        if([delegate respondsToSelector:@selector(socialLoginFalied)])
        {
            [delegate socialLoginFalied];
        }
    }
}

+ (NSString *)getAPIPath
{
    return [NSString stringWithFormat:@"%@/login_social.php",API_URL];
}

#pragma API Delegates

-(void) didFetchObjects:(id)objects ForClass:(Class)klass withParams:(NSDictionary *)params
{
    
}

-(void) didFailForClass:(Class)klass withError:(NSError *)error andParams:(NSDictionary *)dictionary
{
    
}


@end
