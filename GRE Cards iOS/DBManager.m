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
{
    BOOL isTransactionSetup;
    sqlite3_stmt *word_stmt;
    sqlite3_stmt *def_stmt;
    sqlite3_stmt *sent_stmt;
    sqlite3_stmt *synm_stmt;
    sqlite3_stmt *nme_stmt;
}

+ (DBManager*)sharedDBManager
{
    if (!sharedInstance)
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance openDatabase];
        [sharedInstance createDB];
        [sharedInstance setupVariables];
    }
    return sharedInstance;
}

-(void) dealloc
{
    [self closeDatabase];
}

-(void) setupVariables
{
    isTransactionSetup = NO;
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

#pragma Transcation Setup

-(void) startTransaction
{
    if(!isTransactionSetup)
    {
        [sharedInstance setupSQLStatements];
        sqlite3_exec(database, "BEGIN EXCLUSIVE TRANSACTION", 0, 0, 0);
    }
}

-(void) commitTransaction
{
    
}

-(void) endTransaction
{
    if (sqlite3_exec(database, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK)
    {
        NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
    }
}

-(void) setupSQLStatements
{
    //sqlite3_prepare_v2(database, [STMT_TABLE_WORDS cStringUsingEncoding:NSUTF8StringEncoding], -1, word_stmt, NULL);
}

#pragma Adding Word

- (void) addWord:(WordObject *) wordObj
{
    NSLog(@"%@",[wordObj description]);
    //if (sqlite3_step(compiledStatement) != SQLITE_DONE) NSLog(@"DB not updated. Error: %s",sqlite3_errmsg(db));
   //if (sqlite3_reset(compiledStatement) != SQLITE_OK) NSLog(@"SQL Error: %s",sqlite3_errmsg(db));
    
//    word_stmt.bindString(1, obj.getWordID());
//    word_stmt.bindString(2, obj.getWord());
//    word_stmt.bindString(3, obj.getDefinition_short());
//    long entryID = word_stmt.executeInsert();
//    word_stmt.clearBindings();
//    
//    for (int i = 0; i < obj.getDefintionArr().size(); i++)
//    {
//        DefinitionObject data = obj.getDefintionArr().get(i);
//        if(data.getDefinition() != null)
//        {
//            def_stmt.bindLong(1, entryID);
//            def_stmt.bindString(2, data.getDefinition());
//            long defID = def_stmt.executeInsert();
//            def_stmt.clearBindings();
//            for (int j = 0; j < data.getSentence().size(); j++)
//            {
//                if(data.getSentence().get(j) != null)
//                {
//                    sent_stmt.bindLong(1, defID);
//                    sent_stmt.bindString(2, data.getSentence().get(j));
//                    sent_stmt.executeInsert();
//                    sent_stmt.clearBindings();
//                }
//            }
//            
//            for (int j = 0; j < data.getSynonym().size(); j++)
//            {
//                if(data.getSynonym().get(j) != null)
//                {
//                    synm_stmt.bindLong(1, defID);
//                    synm_stmt.bindString(2, data.getSynonym().get(j));
//                    synm_stmt.executeInsert();
//                    synm_stmt.clearBindings();
//                }
//            }
//        }
//    }
//    
//    for (int i = 0; i < obj.getMnemonics_arr().size(); i++)
//    {
//        if(obj.getMnemonics_arr().get(i) != null)
//        {
//            nmen_stmt.bindLong(1, entryID);
//            nmen_stmt.bindString(2, obj.getMnemonics_arr().get(i));
//            nmen_stmt.executeInsert();
//            nmen_stmt.clearBindings();
//        }
//    }
}

@end
