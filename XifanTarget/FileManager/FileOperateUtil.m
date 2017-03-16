//
//  FileOperateUtil.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "FileOperateUtil.h"
#import "CommonMacro.h"


@implementation FileOperateUtil


+ (NSString *)getCacheDirPath
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/", [cacPath objectAtIndex:0], xfCacheDirName];
    return cachePath;
}

+ (void)writeFile:(NSString *)text fileName:(NSString *)fileName
{
    NSString *cachePath =[self getCacheDirPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cachePath]) {
        BOOL res=[fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res)
            NSLog(@"Create dir success");
        else
            NSLog(@"Create dir fail");
    }
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:filePath]) {
        BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (res) {
            NSLog(@"Create file success: %@" ,filePath);
        } else {
            NSLog(@"Create file fail");
        }
    }
    
    BOOL res=[text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"Write file success");
    } else
        NSLog(@"Write file fail");
}

+ (NSString *)readFile:(NSString *)fileName
{
    NSString *documentsPath =[self getCacheDirPath];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    NSString *content=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return  content;
}

+ (void)writeDataToFile:(NSData *)data fileName:(NSString *)fileName
{
    NSString *cachePath =[self getCacheDirPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cachePath]) {
        BOOL res=[fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res)
            NSLog(@"Create dir success");
        else
            NSLog(@"Create dir fail");
    }
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:filePath]) {
        BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if (res) {
            NSLog(@"Create file success: %@" ,filePath);
        } else {
            NSLog(@"Create file fail");
        }
    }
    
    BOOL res = [data writeToFile:filePath atomically:YES];
    if (res) {
        NSLog(@"Write file success");
    } else
        NSLog(@"Write file fail");
}

+ (void)deleteFile:(NSString *)fileName {
    NSString *cachePath =[self getCacheDirPath];
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL res = [fileManager removeItemAtPath:filePath error:nil];
        if (res) {
            NSLog(@"Remove file success: %@", filePath);
        } else {
            NSLog(@"Remove file fail");
        }
    }
    
}

+ (BOOL)checkFileExists:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath =[self getCacheDirPath];
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:filePath];
}


@end
