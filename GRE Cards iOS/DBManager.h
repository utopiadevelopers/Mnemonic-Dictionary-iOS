//
//  DBManager.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 29/08/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "WordObject.h"


#define TABLE_WORDS @"word_list"
#define COLUMN_ID @"_id"
#define COLUMN_SERVER_WORDID @"server_word_id"
#define COLUMN_WORD @"word"
#define COLUMN_DEF_SHORT @"definition_short"
#define COLUMN_IS_FAV @"is_fav"
#define COLUMN_IS_FAV_DIRTY @"is_fav_dirty"
#define COLUMN_FAV_TIMESTAMP @"fav_timestamp"
#define COLUMN_IS_IGNORE @"is_ignore"
#define COLUMN_IS_IGNORE_DIRTY @"is_ignore_dirty"
#define COLUMN_IGNORE_TIMESTAMP @"ignore_timestamp"
#define COLUMN_IS_HISTORY @"is_history"
#define COLUMN_IS_HISTORY_DIRTY @"is_history_dirty"
#define COLUMN_HISTORY_TIMESTAMP @"history_timestamp"

#define DATABASE_WORD_LIST (@"create table " TABLE_WORDS @"(" TABLE_WORDS  @"("   COLUMN_ID  @" integer primary key autoincrement, "   COLUMN_SERVER_WORDID  @" integer,"   COLUMN_WORD  @" text not null,"   COLUMN_DEF_SHORT  @" text not null,"   COLUMN_IS_FAV  @" TINYINT DEFAULT 0,"   COLUMN_IS_FAV_DIRTY  @" TINYINT DEFAULT 0,"   COLUMN_FAV_TIMESTAMP  @" DATETIME,"   COLUMN_IS_IGNORE  @" TINYINT DEFAULT 0,"   COLUMN_IS_IGNORE_DIRTY  @" TINYINT DEFAULT 0,"   COLUMN_IGNORE_TIMESTAMP  @" DATETIME,"   COLUMN_IS_HISTORY  @" TINYINT DEFAULT 0,"   COLUMN_IS_HISTORY_DIRTY  @" TINYINT DEFAULT 0,"   COLUMN_HISTORY_TIMESTAMP  @" DATETIME" @");")
#define DROP_TABLE_WORDS (@"DROP TABLE IF EXISTS " TABLE_WORDS)



#define TABLE_DEFINITION_WORD_LIST @"definition_word_list"
#define COLUMN_WORD_ID @"_wordID"
#define COLUMN_DEFINITION @"definition"
#define COLUMN_DEFINITION_ID @"_definitionID"

#define DATABASE_DEFINITION_WORD_LIST (@"create table "   TABLE_DEFINITION_WORD_LIST  @"("   COLUMN_DEFINITION_ID  @" integer primary key autoincrement, "   COLUMN_WORD_ID  @" integer, "   COLUMN_DEFINITION  @" text not null"  @", FOREIGN KEY("   COLUMN_WORD_ID  @") REFERENCES "   TABLE_WORDS  @"("   COLUMN_ID  @") );")
#define DROP_TABLE_DEFINITION_WORD_LIST (@"DROP TABLE IF EXISTS " TABLE_DEFINITION_WORD_LIST)



#define TABLE_MNEMONICS_WORD_LIST @"mnemonics_word_list"
#define COLUMN_MNEMONICS @"mnemonics"

#define DATABASE_MNEMONICS_WORD_LIST (@"create table "   TABLE_MNEMONICS_WORD_LIST  @"("   COLUMN_ID  @" integer primary key autoincrement, "   COLUMN_WORD_ID  @" integer, "   COLUMN_MNEMONICS  @" text not null"  @", FOREIGN KEY("   COLUMN_WORD_ID  @") REFERENCES "   TABLE_WORDS  @"("   COLUMN_ID  @") );")
#define DROP_TABLE_MNEMONICS_WORD_LIST (@"DROP TABLE IF EXISTS " TABLE_MNEMONICS_WORD_LIST)



#define TABLE_SENTENCE_WORD_LIST @"sentence_word_list"
#define COLUMN_SENTENCE @"sentence"

#define DATABASE_SENTENCE_WORD_LIST (@"create table "   TABLE_SENTENCE_WORD_LIST  @"("   COLUMN_ID  @" integer primary key autoincrement, "   COLUMN_DEFINITION_ID  @" integer, "   COLUMN_SENTENCE  @" text not null"  @", FOREIGN KEY("   COLUMN_DEFINITION_ID  @") REFERENCES "   TABLE_DEFINITION_WORD_LIST  @"("   COLUMN_DEFINITION_ID  @") );")
#define DROP_TABLE_SENTENCE_WORD_LIST (@"DROP TABLE IF EXISTS " TABLE_SENTENCE_WORD_LIST)



#define TABLE_SYNONYM_WORD_LIST @"synonym_word_list"
#define COLUMN_SYNONYM @"synonym"

#define DATABASE_SYNONYM_WORD_LIST (@"create table "   TABLE_SYNONYM_WORD_LIST  @"("   COLUMN_ID  @" integer primary key autoincrement, "   COLUMN_DEFINITION_ID  @" integer, "   COLUMN_SYNONYM  @" text not null"  @", FOREIGN KEY("   COLUMN_DEFINITION_ID  @") REFERENCES "   TABLE_DEFINITION_WORD_LIST  @"("   COLUMN_DEFINITION_ID  @") );")
#define DROP_TABLE_SYNONYM_WORD_LIST (@"DROP TABLE IF EXISTS " TABLE_SYNONYM_WORD_LIST)

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+ (DBManager*)sharedDBManager;

- (void) openDatabase;
- (void) closeDatabase;
- (BOOL) createDB;
- (void) dropDatabase;
- (void) addWord:(WordObject *) wordObj;

@end
