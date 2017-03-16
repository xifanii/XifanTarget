//  网络请求基类
//  BaseNetworkUtil.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMacro.h"
#import "ServerUtil.h"

#import "BaseRequestInfo.h"


@interface BaseNetworkUtil : NSObject

/**
 *  发送请求至服务器，Get请求
 *
 *  @param url    请求地址后缀
 *  @param params 请求参数
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
- (void)getToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  自定义请求地址，Get请求
 *
 *  @param url    自定义请求地址
 *  @param params 请求参数
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
- (void)getToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  发送请求至服务器,Post请求
 *
 *  @param url    请求地址后缀
 *  @param params 请求参数
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
- (void)postToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

/**
 *  自定义请求地址,Post请求
 *
 *  @param url    自定义请求地址
 *  @param params 请求参数
 *  @param successfulBlock  成功请求回调
 *  @param failureBlock     失败请求回调
 */
- (void)postToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock;

@end
