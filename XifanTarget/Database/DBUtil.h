//  数据库操作类
//  DBUtil.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDBHelpers.h>

@interface DBUtil : NSObject

{
    DBUtil *dbhelper;
    FMDatabase *db;
    NSString *dbPath;
}

/**
 *  获取操作类实例
 *
 *  @return 操作类实例
 */
+(DBUtil *)sharedInstance;

/**
 *  打开数据库
 */
- (void)openDB;

/**
 *  关闭数据库
 */
- (void)closeDB;


- (int)selectUserEducationInfoDataCount;

- (int)selectUserScoreDataCount;


//  成绩信息表
/**
 *  创建User Score表
 */
- (void)createUserScoreTable;

/**
 *  插入User Score数据
 *
 *  @param info 参数对象
 */
- (void)insertUserScoreData:(NSDictionary *)info;

/**
 *  删除User Score数据
 */
- (void)deleteUserScoreData;

- (void)updateUserScoreId:(NSString *)scoreId;

- (void)updateUserScoreSchoolOptionNumbers:(NSString *)schoolNumbers;
/**
 *  查询User Score数据
 *
 *  @param cond 查询条件
 *
 *  @return 查询结果集
 */
- (NSMutableArray *) selectUserScoreData:(NSString *)cond;

- (NSMutableArray *) selectUserScoreDataForGetBatch:(NSString *)cond;


//  教育基本信息表
/**
 *  创建UserEducationInfo表
 */
- (void)createUserEducationInfoTable;

/**
 *  插入UserEducationInfo数据
 *
 *  @param info 参数对象
 */
- (void)insertUserEducationInfoData:(NSDictionary *)info;

/**
 *  删除UserEducationInfo数据
 */
- (void)deleteUserEducationInfoData;


/**
 *  查询UserEducationInfo数据
 *
 *  @param cond 查询条件
 *
 *  @return 查询结果集
 */
- (NSMutableArray *) selectUserEducationInfoData:(NSString *)cond;



@end
