//
//  ServerUtil.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "ServerUtil.h"
#import <AFNetworking.h>
#import "UMMobClick/MobClick.h"

static ServerUtil *util = nil;
@interface ServerUtil ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ServerUtil

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[ServerUtil alloc] init];
        util.sessionManager = [AFHTTPSessionManager manager];
        
    });
    return util;
}

- (instancetype)init
{
    static id obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super init];
        if (obj) {
            
        }
    });
    self = obj;
    return self;
}

+ (void)getToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    showNetworkActivityIndicator(YES);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [[ServerUtil sharedInstance].sessionManager.requestSerializer setTimeoutInterval:SERVER_TIMEOUT];
    
    [ServerUtil sharedInstance].sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    
    NSDictionary *parameters = nil;
    
    NSString *requestUrl = url;
    
//    NSString *request = [ToolsUtil getCurrentRequestFromGetUrl:url];
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[ServerUtil sharedInstance].sessionManager GET:requestUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successfulBlock) {
            successfulBlock(responseObject);
        }
        showNetworkActivityIndicator(NO);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(nil);
        } else {
           
        }
        
//        if(error){
//            NSDictionary *dict = @{@"data_id" : request, @"msg" : [NSString stringWithFormat:@"localcode = %li, description = %@", (long)error.code, error.localizedDescription]};
//            [MobClick event:@"http_fail" attributes:dict];
//        }
        
        showNetworkActivityIndicator(NO);
    }];
}


+ (void)getToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    [self getToServerForCustomURL:[NSString stringWithFormat:@"%@%@", BASE_HTTP_URL_POST, url] params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}


+ (void)postToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    showNetworkActivityIndicator(YES);
    [[ServerUtil sharedInstance].sessionManager.requestSerializer setTimeoutInterval:SERVER_TIMEOUT];
    
    [[ServerUtil sharedInstance].sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (successfulBlock) {
            successfulBlock(responseObject);
        }
        showNetworkActivityIndicator(NO);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            failureBlock(nil);
        } else {
            
        }
        
        showNetworkActivityIndicator(NO);
    }];
    
}

+ (void)postToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    [self postToServerForCustomURL:[NSString stringWithFormat:@"%@%@", BASE_HTTP_URL_POST, url] params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}


+ (NSInteger)getResultCode:(NSDictionary *)dict
{
    return 0;
}

+ (NSArray *)getErrorCode:(NSDictionary *)dict
{
    NSInteger code = [dict[@"code"] integerValue];
    
    NSString *resultString = dict[@"msg"];
    
    switch (code) {
        case HTTP_RESPONSE_ERROR_CODE_SUCCESS: {
            resultString = NSLocalizedString(@"http_response_success", nil);
            break;
        }
        case HTTP_RESPONSE_ERROR_CODE_PARAMETER_ERROR: {
            resultString = NSLocalizedString(@"http_response_parameter_error", nil);
            break;
        }
        case HTTP_RESPONSE_ERROR_CODE_PARAMETER_TYPE_ERROR: {
            resultString = NSLocalizedString(@"http_response_parameter_type_error", nil);
            break;
        }
        case HTTP_RESPONSE_ERROR_CODE_PARAMETER_MISSING: {
            resultString = NSLocalizedString(@"http_response_parameter_missing", nil);
            break;
        }
        case HTTP_RESPONSE_ERROR_CODE_SERVER_ERROR: {
            resultString = NSLocalizedString(@"http_response_server_error", nil);
            break;
        }
    }
    
    return @[ @(code), resultString ? : NSLocalizedString(@"alert_server_died", nil) ];
}


@end
