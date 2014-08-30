//
//  DBManager.m
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 29/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;

@implementation DBManager

+ (DBManager*)sharedDBManager
{
    if (!sharedInstance)
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance openDatabase];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(void) dealloc
{
    [self closeDatabase];
}

#pragma Open and Close DB

-(void) openDatabase
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) != SQLITE_OK)
    {
        NSLog(@"Failed to open/create database");
    }
}

-(void) closeDatabase
{
    sqlite3_close(database);
}

#pragma Database Creation

-(BOOL) createDB
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"utopia_gre.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            sqlite3_exec(database, [DATABASE_WORD_LIST UTF8String], NULL, NULL,&errMsg);
            sqlite3_exec(database, [DATABASE_DEFINITION_WORD_LIST UTF8String], NULL, NULL,&errMsg);
            sqlite3_exec(database, [DATABASE_MNEMONICS_WORD_LIST UTF8String], NULL, NULL,&errMsg);
            sqlite3_exec(database, [DATABASE_SENTENCE_WORD_LIST UTF8String], NULL, NULL,&errMsg);
            sqlite3_exec(database, [DATABASE_SYNONYM_WORD_LIST UTF8String], NULL, NULL,&errMsg);
            sqlite3_close(database);
            return  isSuccess;
        }
        else
        {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

-(void) dropDatabase
{
    char *errMsg;
    sqlite3_exec(database,[DROP_TABLE_WORDS UTF8String], NULL, NULL,&errMsg);
    sqlite3_exec(database,[DROP_TABLE_MNEMONICS_WORD_LIST UTF8String], NULL, NULL,&errMsg);
    sqlite3_exec(database,[DROP_TABLE_DEFINITION_WORD_LIST UTF8String], NULL, NULL,&errMsg);
    sqlite3_exec(database,[DROP_TABLE_SYNONYM_WORD_LIST UTF8String], NULL, NULL,&errMsg);
    sqlite3_exec(database,[DROP_TABLE_SENTENCE_WORD_LIST UTF8String], NULL, NULL,&errMsg);
}

-(void) addWord
{
    
}

@end
