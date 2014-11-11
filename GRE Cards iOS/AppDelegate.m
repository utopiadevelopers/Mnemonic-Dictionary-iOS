//
//  AppDelegate.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 20/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Pre Launch Setup
    
    // Setup Database
    //[self setUpDatabase];
    
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:[CommonFunction getSplashViewController]];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma App Delegate Methods

- (void) setUpDatabase
{
    NSString* documentPath = [DBManager getDatabasePath];
    BOOL dbFileExists = [[NSFileManager alloc] fileExistsAtPath:documentPath];
    
    if(!dbFileExists)
    {
        [self copyPackagedDbToPath:documentPath];
    }
    
    dbFileExists = [[NSFileManager alloc] fileExistsAtPath:documentPath];
    
    if(dbFileExists)
    {
        [self updateDatabase];
    }
    else
    {
        NSAssert(0, @"[ERROR] Could not copy packaged database");
    }
}

- (void) copyPackagedDbToPath: (NSString *)dbPath
{
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"assets/package.db"];
    NSData *compressedData = [[NSData alloc] initWithContentsOfFile:defaultDBPath];
    
    //NSData *uncompressedData = [CommonFunction gzipInflate:compressedData];
    
    BOOL dbFileExists = [[NSFileManager alloc] fileExistsAtPath:defaultDBPath];
    
    if(!dbFileExists)
    {
        NSAssert(0, @"Packaged file does not exist.");
    }
    
    //[uncompressedData writeToFile:dbPath atomically:YES];
}

- (void) updateDatabase
{
    sqlite3 *tempConnection;
    NSString *documentPath = [DBManager getDatabasePath];
    
    if(sqlite3_open([documentPath UTF8String], &tempConnection) != SQLITE_OK)
    {
        NSAssert1(0, @"[ERROR] Could not connect to database - %s", sqlite3_errmsg(tempConnection));
    }
    else
    {
        [self copyPackagedDbToPath:[DBManager getDatabasePath]];
    }
    
    sqlite3_close(tempConnection);
}


#pragma Social Login

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation
{
    if([[url scheme] isEqualToString:@"fb1452417911661818"])
    {
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    }
    else
    {
        return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}

@end
