//
//  APIManager.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 07/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>

@protocol APIManagerDelegate <NSObject>

@required
- (void) didFetchObjects:(id)objects ForClass:(Class)klass withParams:(NSDictionary *)params;

@required
- (void) didFailForClass:(Class) klass withError:(NSError *) error andParams:(NSDictionary *)dictionary;
@end


@interface APIManager : AFHTTPRequestOperationManager

@property (strong, nonatomic) AFHTTPRequestOperationManager *apiManager;

+ (APIManager *)sharedApiManager;
+ (NSURL *) getAPIBaseUrl;
- (void) getRequestForClass:(Class)Klass WithParameters:(NSDictionary *)params withDelegate:(id)callbackDelegate;
- (void) postRequestForClass:(Class)Klass WithPostParameters:(NSDictionary *)postParams withDelegate:(id)callbackDelegate;
- (void) cancelAllRequestsForClass:(Class)klass;

@end
