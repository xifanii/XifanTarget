//
//  BaseNetworkUtil.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "BaseNetworkUtil.h"

@implementation BaseNetworkUtil

- (void)getToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    url = [url stringByAppendingFormat:@"&_vcode=%@&_platform=%@&_appid=%@&interface_v=%@", xfAppVersionCode, xfAppPlatform, xfAppId, xfInterfaceVersion];
    [ServerUtil getToServer:url params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}

- (void)getToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    url = [url stringByAppendingFormat:@"&_vcode=%@&_platform=%@&_appid=%@&interface_v=%@", xfAppVersionCode, xfAppPlatform, xfAppId, xfInterfaceVersion];
    [ServerUtil getToServerForCustomURL:url params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}

- (void)postToServer:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    NSDictionary *baseInfoDict = @{ @"_vcode" : xfAppVersionCode,
                                    @"_platform" : xfAppPlatform,
                                    @"_appid" : xfAppId,
                                    @"interface_v" : xfInterfaceVersion
                                    };
    if ([params isKindOfClass:[NSMutableDictionary class]]) {
        [params addEntriesFromDictionary:baseInfoDict];
    } else {
        NSMutableDictionary *paramDict = [params mutableCopy];
        [paramDict addEntriesFromDictionary:baseInfoDict];
        params = paramDict;
    }
    
    [ServerUtil postToServer:url params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}

- (void)postToServerForCustomURL:(NSString *)url params:(id)params successfulBlock:(void(^)(NSDictionary *))successfulBlock failureBlock:(void(^)(NSDictionary *))failureBlock
{
    NSDictionary *baseInfoDict = @{ @"_vcode" : xfAppVersionCode,
                                    @"_platform" : xfAppPlatform,
                                    @"_appid" : xfAppId,
                                    @"interface_v" : xfInterfaceVersion
                                    };
    if ([params isKindOfClass:[NSMutableDictionary class]]) {
        [params addEntriesFromDictionary:baseInfoDict];
    } else {
        NSMutableDictionary *paramDict = [params mutableCopy];
        [paramDict addEntriesFromDictionary:baseInfoDict];
        params = paramDict;
    }
    
    [ServerUtil postToServerForCustomURL:url params:params successfulBlock:successfulBlock failureBlock:failureBlock];
}


@end
