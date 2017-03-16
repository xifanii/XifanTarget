//
//  Constants.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import <UIKit/UIKit.h>

//////////////////////////////  APP 配置相关  //////////////////////////////
static NSString * const xfAppId = @"xifan";
static NSString * const xfAppPlatform = @"iOS";
static NSString * const xfAppChannel = @"official";
static NSString * const xfAppVersionCode = @"1";
static NSString * const xfInterfaceVersion = @"1";


//////////////////////////////  第三方配置相关  //////////////////////////////

#define APP_KEY_UMENG             @"55a9ff4d67e58e0df30057a8"
#define APP_KEY_UMENG_ADHOC       @"56a344d7e0f55a38fd000bf7"


///////////////////////////  与HTML5交互相关配置  ////////////////////////////




//////////////////////////////  通知处理  //////////////////////////////

//  规范化通知
#define NOTIFICATION_TEST @"Notification_Test"




//////////////////////////////  Cache  //////////////////////////////

//  缓存文件夹名
static NSString * const xfCacheDirName = @"WanMeiZhiYuanCache";



//////////////////////////////  ENUM  //////////////////////////////

////  筛选类型
typedef NS_ENUM(NSInteger, Enum_test)
{
    Type_xf1 = 0,   //类型1
    Type_xf2 = 1,   //类型2
    Type_xf3 = 2,   //类型3
};

static NSString * const Type_xf_1 = @"Type_xf1";
static NSString * const Type_xf_2 = @"Type_xf2";
static NSString * const Type_xf_3 = @"Type_xf3";

static const CGFloat xfUITableViewHeaderHeight = 60.f;

#endif /* Constants_h */
