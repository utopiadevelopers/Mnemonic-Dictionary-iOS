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
        [sharedInstance createDB];
        [sharedInstance openDatabase];
    }
    return sharedInstance;
}

-(void) dealloc
{
    [self closeDatabase];
}

#pragma Static Functions

+ (NSString *) getDatabasePath
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"utopia_gre.db"]];
    
    return databasePath;
}

+ (NSString *) getTemporaryDatabasePath
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"utopia_gre_temp.db"]];
    
    return databasePath;
}


#pragma Open and Close DB

-(void) openDatabase
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) != SQLITE_OK)
    {
        NSLog(@"Error %s", sqlite3_errmsg(database));
    }
}

-(void) closeDatabase
{
    sqlite3_close(database);
}

#pragma Database Creation

-(BOOL) createDB
{
    databasePath = [DBManager getDatabasePath];
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
            NSLog(@"Failed to open/create database : %s", sqlite3_errmsg(database));
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
    sqlite3_exec(database, "BEGIN", 0, 0, 0); // Begin Transaction
}

-(void) commitTransaction
{
    if (sqlite3_exec(database, "COMMIT", 0, 0, 0) != SQLITE_OK) // Complete Transaction
    {
        NSLog(@"SQL Error: %s",sqlite3_errmsg(database));
    }
}

-(NSMutableArray*) getWordList
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    sqlite3_stmt    *statement;
    NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@ FROM %@ ORDER BY %@",COLUMN_SERVER_WORDID,COLUMN_WORD,COLUMN_DEF_SHORT,TABLE_WORDS,COLUMN_WORD];
    const char *query_stmt = [querySQL UTF8String];
    if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            WordObject *wordObj = [[WordObject alloc] init];
            [wordObj setWordID:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]];
            [wordObj setWord:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]];
            [wordObj setDefinition_short:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]];
            [array addObject:wordObj];
        }
        sqlite3_finalize(statement);
    }
    return array;
}


#pragma Adding Word

- (void) addWord:(WordObject *) wordObj
{
    if(sqlite3_prepare_v2(database, [STMT_TABLE_WORDS UTF8String], -1, &word_stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(word_stmt, 1, [[wordObj wordID] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(word_stmt, 2, [[[wordObj word] lowercaseString] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(word_stmt, 3, [[wordObj definition_short] UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(word_stmt) == SQLITE_DONE)
        {
            NSLog(@"Word Inserted : %@",[wordObj word]);
        }
        else
        {
            NSLog(@"Error While Inserting");
        }
        sqlite3_finalize(word_stmt);
    }
    else
    {
        NSLog(@"Error %s while preparing statement", sqlite3_errmsg(database));
    }
    
    
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
