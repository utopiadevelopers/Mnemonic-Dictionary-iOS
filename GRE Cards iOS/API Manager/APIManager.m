//
//  APIManager.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 07/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

typedef void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@synthesize apiManager;


+ (APIManager *)sharedApiManager
{
    static APIManager *_sharedApiManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedApiManager = [[APIManager alloc] init];
        [_sharedApiManager setApiManager:[[AFHTTPRequestOperationManager alloc] initWithBaseURL:[self getAPIBaseUrl]]];
        [_sharedApiManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        
    });
    return _sharedApiManager;

}

+ (NSMutableDictionary*) accessTokenDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [dict setValue:[prefs valueForKey:AUTH_KEY] forKey:@"access_token"];
    return dict;
}

+ (NSURL *) getAPIBaseUrl
{
    NSURLComponents *URLComponent = [[NSURLComponents alloc] init];
    
    [URLComponent setScheme:@"http"];
    [URLComponent setHost:HOST];
    [URLComponent setPath:@"/"];
    
    return [URLComponent URL];
}

- (void) getRequestForClass:(Class)Klass WithParameters:(NSDictionary *)params withDelegate:(id)callbackDelegate
{
    NSString *apiPath = [Klass getAPIPath];
    NSString *queryString = [CommonFunction getQueryStringFromDictionary:params];
    apiPath = [self getAPIPath:apiPath WithQureyString:queryString];
    
    successBlock requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([callbackDelegate respondsToSelector:@selector(didFetchObjects:ForClass:withParams:)])
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
            {
                if ([[callbackDelegate class] isSubclassOfClass:[UtopiaObject class]])
                {
                    [callbackDelegate parseObject:responseObject withInitialParams:params];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    [callbackDelegate didFetchObjects:responseObject ForClass:Klass withParams:params];
                });
            });
        }
    };
    
    failureBlock requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if([callbackDelegate respondsToSelector:@selector(didFailForClass:withError:andParams:)])
        {
            [callbackDelegate didFailForClass:Klass withError:error andParams:params];
        }
            
    };
    
    AFHTTPRequestOperation *requestOperation = [apiManager GET:apiPath parameters:nil success:requestSuccess failure:requestFailure];
    [requestOperation setQueuePriority:NSOperationQueuePriorityHigh];
    
    
    //Log request
    if(DEBUG)
    {
        NSLog(@"%@",[[requestOperation request] URL]);
    }
}

- (void) postRequestForClass:(Class)Klass WithPostParameters:(NSDictionary *)postParams withDelegate:(id)callbackDelegate
{
    
}

- (void) cancelAllRequestsForClass:(Class)klass
{
    
}

- (NSString *)getAPIPath:(NSString *)apiPath WithQureyString:(NSString *)queryString
{
    if([apiPath rangeOfString:@"?"].location == NSNotFound)
    {
        apiPath = [apiPath stringByAppendingFormat:@"?%@", queryString];
    }
    else
    {
        apiPath = [apiPath stringByAppendingFormat:@"&%@", queryString];
    }
    return apiPath;
}

- (void)logResponse:(id)response forOperation:(AFHTTPRequestOperation *)operation
{
    NSLog(@"Request URL: %@",[[operation request] URL]);
}

@end
