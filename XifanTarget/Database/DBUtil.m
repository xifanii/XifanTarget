//
//  DBUtil.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "DBUtil.h"

#define DB_NAME @"userscore.sqlite"
#define TABLE_NAME_USER_SCORE @"user_score"
#define TABLE_NAME_USER_EDUCATION_INFO @"user_education_info"

@implementation DBUtil


#pragma mark - Count

- (int)selectUserScoreDataCount
{
    return [self selectDataCount:TABLE_NAME_USER_SCORE];
}

- (int)selectUserEducationInfoDataCount
{
    return [self selectDataCount:TABLE_NAME_USER_EDUCATION_INFO];
}


#pragma mark Create Table
- (void)createUserScoreTable
{
    NSArray *columnArr = @[ @"score_id",
                            @"score",
                            @"school_option_numbers",
                            @"grade_rank",
                            @"grade_cnt",
                            @"max_score",
                            @"time",
                             ];
    [self createTable:TABLE_NAME_USER_SCORE columns:columnArr constraints:nil];
}

- (void)createUserEducationInfoTable
{
    NSArray *columnArr = @[ @"user_id",
                            @"user_token",
                            @"user_gaokao_location",
                            @"user_wenli",
                            @"user_school_vip_bk_ratio",
                            @"user_school_bk_ratio",
                            @"user_dream_sch_id",
                            ];
    [self createTable:TABLE_NAME_USER_EDUCATION_INFO columns:columnArr constraints:nil];
}

#pragma mark Insert
- (void)insertUserScoreData:(NSDictionary *)info
{
    
    NSDictionary *dict = @{ @"score_id":info[@"score_id"],
                            @"score":info[@"score"],
                            @"grade_rank":info[@"grade_rank"],
                            @"grade_cnt":info[@"grade_cnt"],
                            @"max_score":info[@"max_score"] == nil ? @"750" : info[@"max_score"],
                            @"time":info[@"time"],
                            };
    
    [self insertData:TABLE_NAME_USER_SCORE rowDict:dict];
    
}

- (void)insertUserEducationInfoData:(NSDictionary *)info
{
    
    NSDictionary *dict = @{ @"user_id":info[@"user_id"],
                            @"user_token":info[@"user_token"],
                            @"user_gaokao_location":info[@"user_gaokao_location"],
                            @"user_wenli":info[@"user_wenli"],
                            @"user_school_vip_bk_ratio":info[@"user_school_vip_bk_ratio"],
                            @"user_school_bk_ratio":info[@"user_school_bk_ratio"],
                            @"user_dream_sch_id":info[@"user_dream_sch_id"],
                            };
    
    [self insertData:TABLE_NAME_USER_EDUCATION_INFO rowDict:dict];
    
}

#pragma mark Select

- (NSMutableArray *) selectUserScoreDataForGetBatch:(NSString *)cond
{
    if (cond == nil || cond.length < 1) {
        cond = @" 1=1 ";
    }
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT score, grade_rank FROM %@ where %@ ",TABLE_NAME_USER_SCORE, cond];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[rs stringForColumn:@"score"] forKey:@"score"];
            [dict setValue:[rs stringForColumn:@"grade_rank"] forKey:@"grade_rank"];
            [resultList addObject:dict];
        }
    }
    return resultList;
}

- (NSMutableArray *) selectUserScoreData:(NSString *)cond
{
    if (cond == nil || cond.length < 1) {
        cond = @" 1=1 ";
    }
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where %@ ",TABLE_NAME_USER_SCORE, cond];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[rs stringForColumn:@"score_id"] forKey:@"score_id"];
            [dict setValue:[rs stringForColumn:@"school_option_numbers"] forKey:@"school_option_numbers"];
            [dict setValue:[rs stringForColumn:@"score"] forKey:@"score"];
            [dict setValue:[rs stringForColumn:@"grade_rank"] forKey:@"grade_rank"];
            [dict setValue:[rs stringForColumn:@"grade_cnt"] forKey:@"grade_cnt"];
            [dict setValue:[rs stringForColumn:@"max_score"] forKey:@"max_score"];
            [dict setValue:[rs stringForColumn:@"time"] forKey:@"time"];
            
            [resultList addObject:dict];
        }
    }
    return resultList;
}

- (NSMutableArray *) selectUserEducationInfoData:(NSString *)cond
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where %@ ",TABLE_NAME_USER_EDUCATION_INFO, cond];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[rs stringForColumn:@"user_id"] forKey:@"user_id"];
            [dict setValue:[rs stringForColumn:@"user_token"] forKey:@"user_token"];
            [dict setValue:[rs stringForColumn:@"user_gaokao_location"] forKey:@"user_gaokao_location"];
            [dict setValue:[rs stringForColumn:@"user_wenli"] forKey:@"user_wenli"];
            [dict setValue:[rs stringForColumn:@"user_school_vip_bk_ratio"] forKey:@"user_school_vip_bk_ratio"];
            [dict setValue:[rs stringForColumn:@"user_school_bk_ratio"] forKey:@"user_school_bk_ratio"];
            [dict setValue:[rs stringForColumn:@"user_dream_sch_id"] forKey:@"user_dream_sch_id"];
            
            [resultList addObject:dict];
        }
    }
    return resultList;
}

//UserEducationInfo
#pragma mark Delete
- (void)deleteUserScoreData
{
    if ([db open]) {
        [self deleteData:TABLE_NAME_USER_SCORE];
    }
}

- (void)deleteUserEducationInfoData
{
    if ([db open]) {
        [self deleteData:TABLE_NAME_USER_EDUCATION_INFO];
    }
}

#pragma mark - Update
- (void)updateUserScoreId:(NSString *)scoreId
{
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"UPDATE %@ SET '%@' = '%@' WHERE %@ ",TABLE_NAME_USER_SCORE, @"SCORE_ID", scoreId, @"SCORE_ID = '' " ];
        [db executeUpdate:sql];
    }
}

- (void)updateUserScoreSchoolOptionNumbers:(NSString *)schoolNumbers
{
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:
                         @"UPDATE %@ SET '%@' = '%@' WHERE TIME = (SELECT MAX(TIME) FROM USER_SCORE ) ",
                         TABLE_NAME_USER_SCORE,
                         @"school_option_numbers",
                         schoolNumbers
                         ];
        [db executeUpdate:sql];
    }
    
}



#pragma mark Common Opt

- (int)selectDataCount:(NSString *)tableName
{
    NSString *countSql = [NSString stringWithFormat:@"select count(*) from %@", tableName];
    FMResultSet *rs = [db executeQuery:countSql];
    int count = 0;
    while ([rs next]) {
        count =[rs intForColumnIndex:0];
    }
    return count;
}

- (void)createTable:(NSString *)tableName columns:(NSArray *)columns constraints:(NSArray *)constraints
{
    BOOL flag = [db createTableWithName:tableName columns:columns constraints:constraints error:nil];
    if (!flag) {
        NSLog(@"createTable error");
    }
}

- (void)insertData:(NSString *)tableName columns:(NSArray *)columns values:(NSArray *)values
{
    BOOL flag = [db insertInto:tableName columns:columns values:values error:nil];
    if (!flag) {
        NSLog(@"insertData error");
    }
}
- (void)insertData:(NSString *)tableName rowDict:(NSDictionary *)rowDict
{
    NSNumber *number = [db insertInto:tableName row:rowDict error:nil];
    if (!number) {
        NSLog(@"insertData error");
    }
}

- (void)deleteData:(NSString *)tableName cond:(NSString *)cond
{
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM '%@' where %@", tableName, cond];
    BOOL res = [db executeUpdate:deleteSql];
    if (!res) {
        NSLog(@"error when delete message db table");
    } else {
        NSLog(@"success to delete message db table");
    }
}


- (void)deleteData:(NSString *)tableName
{
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM '%@'", tableName];
    BOOL res = [db executeUpdate:deleteSql];
    if (!res) {
        NSLog(@"error when delete message db table");
    } else {
        NSLog(@"success to delete message db table");
    }
}


- (NSString *)checkIsNull:(NSString *)str
{
    if (!str) {
        return @"";
    }
    return str;
}



- (void)openDB
{
    if (!dbPath) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        dbPath = [docPath stringByAppendingPathComponent:DB_NAME];
    }
    
    //获取数据库并打开
    db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Open database failed");
        return ;
    }
}
- (void)closeDB
{
    [db close];
}



static DBUtil * instance = nil;

+ (DBUtil *)sharedInstance
{
    @synchronized(self) {
        if ( instance == nil ) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}


@end
