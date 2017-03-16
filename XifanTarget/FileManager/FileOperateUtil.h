//  文件操作处理类
//  FileOperateUtil.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperateUtil : NSObject

/**
 *  获取缓存目录路径
 *
 *  @return 目录路径
 */
+ (NSString *)getCacheDirPath;

/**
 *  读取文件内容
 *
 *  @param fileName 文件路径
 *
 *  @return 文件内容
 */
+ (NSString *)readFile:(NSString *)fileName;

/**
 *  存取文件内容
 *
 *  @param text     文件内容
 *  @param fileName 文件路径
 */
+ (void)writeFile:(NSString *)text fileName:(NSString *)fileName;

+ (void)writeDataToFile:(NSData *)data fileName:(NSString *)fileName;

+ (void)deleteFile:(NSString *)fileName;

+ (BOOL)checkFileExists:(NSString *)fileName;

@end
