//
//  LoginAPI.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 08/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "LoginAPI.h"
#import "NSString+MD5.h"

@implementation LoginAPI

@synthesize username;
@synthesize password;

-(void) loginWithUserName:(NSString *)user password:(NSString *)pass
{
    [self setUsername:user];
    [self setPassword:pass];
    [[APIManager sharedApiManager] getRequestForClass:[LoginAPI class] WithParameters:[self serializeObject] withDelegate:self];
}

#pragma API Manager

-(NSDictionary *) serializeObject
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:username forKey:@"email"];
    [params setValue:[password MD5] forKey:@"password"];
    return params;
}

-(void) parseObject:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    NSString *auth = [responseObject objectForKey:@"auth"];
    NSString *login = [responseObject objectForKey:@"login"];
    
    
    if([login isEqualToString:LOGIN_SUCCESS])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGGED_IN];
        [[NSUserDefaults standardUserDefaults] setValue:auth forKey:AUTH_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:LOGIN_NORMAL forKey:LOGIN_TYPE];
    }
    else
    {
        [self displayDropdownwithmessage:@"Incorrect Login/Password"];
        [self enableViews];
    }
} failure:nil];

}

+ (NSString *)getAPIPath
{
    return [NSString stringWithFormat:@"%@/login.php",API_URL];
}

#pragma API Delegates

-(void) didFetchObjects:(id)objects ForClass:(Class)klass withParams:(NSDictionary *)params
{
    
}

-(void) didFailForClass:(Class)klass withError:(NSError *)error andParams:(NSDictionary *)dictionary
{
    
}

@end
