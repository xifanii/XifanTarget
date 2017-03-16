//  工具类
//  ToolsUtil.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToolsUtil : NSObject

/**
 *  保存用户配置
 *
 *  @param dic 用户配置
 */
+ (void)saveUserConfigToNSUserDefaults:(NSDictionary *)dic;

/**
 *  保存应用配置
 *
 *  @param dic 应用配置
 */
+ (void)saveAppConfigToNSUserDefaults:(NSDictionary *)dic;

/**
 *  保存配置
 *
 *  @param dic      配置内容
 *  @param dictName 配置所属字典名
 */
+ (void)saveToUserDefaults:(NSDictionary *)dic dictName:(NSString *)dictName;

/**
 *  获取配置
 *
 *  @param dictName 配置所属字典名
 *
 *  @return 配置内容
 */
+ (NSDictionary *)getUserDefaults:(NSString *)dictName;

/**
 *  获取用户配置
 *
 *  @return 用户配置
 */
+ (NSDictionary *)getUserConfig;

/**
 *  获取应用配置
 *
 *  @return 应用配置
 */
+ (NSDictionary *)getAppConfig;

/**
 *  判断是否是第一次打开应用
 *
 *  @return 第一次打开：NO， 否则是YES
 */
+ (BOOL)isNotFirstOpenApp;

/**
 *  设置是否是第一次打开应用
 *
 *  @param flag 第一次打开：NO， 否则是YES
 */
+ (void)setIsNotFirstOpenApp:(BOOL)flag;


/**
 *  判断App是否更新，是的话则显示最新feature
 *
 *  @return 已更新返回YES
 */
+ (BOOL)isAppUpdated;

/**
 *  设置App版本号，储存在本地
 *
 *  
 */
+ (void)setAppVersion;

/**
 *  检查字符串是否为空
 *
 *  @param str 要检查的字符串
 *
 *  @return 如果为空，则返回YES，否则是NO
 */
+ (BOOL)checkIsNull:(NSString *)str;

/**
 *  检查是否是数字
 *
 *  @param textString 检查字符
 *
 *  @return 纯数字：YES
 */
+ (BOOL)checkIsNumber:(NSString *)textString;

/**
 *  删除URL中的某个参数
 */
+ (NSString *)deleteParameter:(NSString *)parameter WithOriginUrl:(NSString *)originUrl;

+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param;

/**
 *  检验是否是正确的密码格式
 *
 *  @return 正确为YES
 */
+ (BOOL)isValidatePassword:(NSString *)password;

/**
 *  检验是否是正确的QQ格式
 *
 *  @return 正确为YES
 */
+ (BOOL)isValidateQQ:(NSString *)qq;

/**
 *  检验是否是正确的Email格式
 *
 *  @param email Email
 *
 *  @return 正确为YES
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  校验是否是手机号码格式
 *
 *  @param mobileNum 手机号码
 *
 *  @return 正确为YES
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNum;

/**
 *  校验是否是卡号格式
 *
 *  @param cardNum 卡号
 *
 *  @return 正确为YES
 */
+ (BOOL)isValidateCardAccount:(NSString *)cardNum;

/**
 *  将NSString转为JSON
 *
 *  @param jsonString string参数
 *
 *  @return JSON返回值
 */
+ (id)JSONValue:(NSString *)jsonString;

/**
 *  将JSON数据转为NSData
 *
 *  @param data JSON参数
 *
 *  @return NSData返回值
 */
+ (NSData*)JSONString:(id)data;

/**
 *  获取当前年份
 *
 *  @return 年份
 */
+ (NSInteger)getCurrentYear;

/**
 *  获取当前月份
 *
 *  @return 月份
 */
+ (NSInteger)getCurrentMonth;

/**
 *  获取当前天
 *
 *  @return 天
 */
+ (NSInteger)getCurrentDay;

/**
 *  根据日期获取年份
 *
 *  @param date 日期
 *
 *  @return 年份
 */
+ (NSInteger)getCurrentYearByDate:(NSDate *)date;

/**
 *  根据日期获取月份
 *
 *  @param date 日期
 *
 *  @return 月份
 */
+ (NSInteger)getCurrentMonth:(NSDate *)date;

/**
 *  根据日期获取天
 *
 *  @param date 日期
 *
 *  @return 天
 */
+ (NSInteger)getCurrentDay:(NSDate *)date;

+ (NSString *) compareCurrentTime:(double)inServerTime;

/**
 *  根据日期获取倒计时
 *
 *  @param targetDate 日期
 *
 *  @return 倒计时
 */
+ (NSString *)getCountdownDay:(NSString *)targetDate;

+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

/**
 *  获取版本信息
 *
 *  @return 版本信息
 */
+ (NSString *)getAppFullVerion;

/**
 *  获取网络状态
 *
 */
+ (NSString *)networkingStatesFromStatebar;

/**
 *  获取设备型号
 *
 */
+ (NSString*)deviceVersion;

/**
 *  判断是否有联网
 *
 */
+ (BOOL)IsEnableInternet;

/**
 *  基于颜色创建图片
 *
 */
+ (UIImage *) createImageWithColor: (UIColor *) color;

/**
 *  基于get请求获取request
 *
 */
+ (NSString *)getCurrentRequestFromGetUrl:(NSString *)url;

/**
 *  基于post请求获取request
 *
 */
+ (NSString *)getCurrentRequestFromPostUrl:(NSString *)url;

/**
 *  获取最顶层视图
 *
 */
+ (UIViewController *)getCurrentVC;

@end
