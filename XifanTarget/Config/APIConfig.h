//
//  APIConfig.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

//  是否是开发模式
#define DEV_MODE   YES

//  服务器请求超时时间
#define SERVER_TIMEOUT                      30

//  分页显示时，每页显示数量
#define PageCount                           20

//  HTTP 服务器地址
#define SERVER_URL                          @"http://xifan.com"

#define MODULE_API                          @"api"

#define BASE_HTTP_URL_POST                  [NSString stringWithFormat:@"%@/%@", SERVER_URL, MODULE_API]

//  APP在AppStore中的链接
#define APP_URL_OF_APPSTORE                 @"itms-apps://itunes.apple.com/app/id...."

//  APP下载网站链接
#define APP_DOWNLOAD_URL                    [NSString stringWithFormat:@"%@/download", SERVER_URL]




typedef NS_ENUM(NSInteger, HTTP_RESPONSE_ERROR_CODE) {
    
    HTTP_RESPONSE_ERROR_CODE_SUCCESS                  = 0,
    
    HTTP_RESPONSE_ERROR_CODE_PARAMETER_ERROR          = 10001,//参数错误
    HTTP_RESPONSE_ERROR_CODE_PARAMETER_TYPE_ERROR     = 10002,//参数类型错误
    HTTP_RESPONSE_ERROR_CODE_PARAMETER_MISSING        = 10003,//参数缺少
    HTTP_RESPONSE_ERROR_CODE_SERVER_ERROR             = 10004,//服务器错误
    
};



#endif /* APIConfig_h */
