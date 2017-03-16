//  服务器请求处理类
//  ServerUtil.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMacro.h"


@interface ServerUtil : NSObject

/**
 *  发送请求至服务器,Get请求
 *
 *  @param url    请求地址后缀
 *  @param params 请求参数(目前为get请求，参数放至请求地址后)
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
+ (void)getToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  自定义请求地址,Get请求
 */
+ (void)getToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  发送请求至服务器,Post请求
 *
 *  @param url    请求地址后缀
 *  @param params 请求参数
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
+ (void)postToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  自定义地址的Post请求
 */
+ (void)postToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  获取HTTP请求响应错误码
 *
 *  @param dict 响应结果
 *
 *  @return 错误码
 */
+ (NSInteger)getResultCode:(NSDictionary *)dict;

/**
 *  获取HTTP请求响应错误码与提示信息
 *
 *  @param dict 响应结果
 *
 *  @return 错误码与提示信息数组
 */
+ (NSArray *)getErrorCode:(NSDictionary *)dict;


@end
