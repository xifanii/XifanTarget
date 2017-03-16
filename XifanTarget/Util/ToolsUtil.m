//
//  ToolsUtil.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "ToolsUtil.h"
#import "sys/utsname.h"
#import "Reachability.h"
#import <UMMobClick/MobClick.h>
#import "CommonMacro.h"


@implementation ToolsUtil

#pragma mark NSUserDefaults配置

+ (void)saveToUserDefaults:(NSDictionary *)dic dictName:(NSString *)dictName
{
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    
    [persistentDefaults setObject:dic forKey:dictName];
    
    if (persistentDefaults)
    {
        [persistentDefaults synchronize];
    }
}

+ (void)saveUserConfigToNSUserDefaults:(NSDictionary *)dic
{
    [self saveToUserDefaults:dic dictName:@"userConfig"];
}

+ (void)saveAppConfigToNSUserDefaults:(NSDictionary *)dic
{
    [self saveToUserDefaults:dic dictName:@"AppConfig"];
}

+ (NSDictionary *)getUserDefaults:(NSString *)dictName
{
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = (NSMutableDictionary *)[persistentDefaults objectForKey:dictName];
    NSDictionary *newUserDict;
    if (!userDict) {
        newUserDict = [[NSMutableDictionary alloc] init];
    } else {
        newUserDict = [userDict mutableCopy];
    }
    return newUserDict;
}


+ (NSDictionary *)getUserConfig
{
    return [self getUserDefaults:@"userConfig"];
}

+ (NSDictionary *)getAppConfig
{
    return [self getUserDefaults:@"AppConfig"];
}

+ (void)setDefaultsUserScoreInfo
{
    NSDictionary *userDict = [ToolsUtil getUserConfig];
    [userDict setValue:@"0" forKey:@"user_last_score"];
    [userDict setValue:@"0" forKey:@"user_yushuying_score"];
    [userDict setValue:@"0" forKey:@"user_zonghe_score"];
    [userDict setValue:@"0" forKey:@"user_zixuan_score"];
    [userDict setValue:@"0" forKey:@"user_jishu_score"];
    [userDict setValue:@"0" forKey:@"user_rank"];
    
    [userDict setValue:@(1000) forKey:@"update_count"];
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:[userDict objectForKey:@"recommend_filter_param_dict"]];
    [paramDict setValue:@"" forKey:@"batch"];
    [paramDict setValue:@"0" forKey:@"score"];
    [paramDict setValue:@"0" forKey:@"ysy_score"];
    [paramDict setValue:@"0" forKey:@"zh_score"];
    [paramDict setValue:@"0" forKey:@"zx_score"];
    [paramDict setValue:@"0" forKey:@"js_score"];
    [paramDict setValue:@"0" forKey:@"rank"];
    [userDict setValue:paramDict forKey:@"recommend_filter_param_dict"];
    
    [ToolsUtil saveUserConfigToNSUserDefaults:userDict];
}

+ (void)setIsNotFirstOpenApp:(BOOL)flag
{
    NSDictionary *dict = [ToolsUtil getAppConfig];
    [dict setValue:[NSNumber numberWithBool:flag] forKey:@"is_not_first_open_app"];
    [ToolsUtil saveAppConfigToNSUserDefaults:dict];
}

+ (BOOL)isNotFirstOpenApp
{
    NSNumber *number = (NSNumber *)[[ToolsUtil getAppConfig] objectForKey:@"is_not_first_open_app"];
    return number.boolValue;
}

+ (BOOL)isAppUpdated
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *lastVersion = [[ToolsUtil getAppConfig] objectForKey:@"app_last_version"];
    
    return ![currentVersion isEqualToString:lastVersion];
}

+ (void)setAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *appConfig = [ToolsUtil getAppConfig];
    [appConfig setValue:currentVersion forKey:@"app_last_version"];
    [ToolsUtil saveAppConfigToNSUserDefaults:appConfig];
}


#pragma mark 字符串操作方法
+ (BOOL)checkIsNull:(NSString *)str
{
    if (str == nil || [str isEqualToString:@""] || str.length <= 0 || [str rangeOfString:@"null"].length > 0 ) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkIsNumber:(NSString *)textString
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

+ (CGRect)getTextRect:(NSString *)text constraintSize:(CGSize)constraintSize font:(UIFont*)font
{
    if (font == nil) {
        font = [UIFont systemFontOfSize:14];
    }
    CGRect rect = [text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font } context:nil];
    rect.size.width = rect.size.width + 1;
    rect.size.height = rect.size.height + 1;
    return rect;
}

+ (NSString *)deleteParameter:(NSString *)parameter WithOriginUrl:(NSString *)originUrl
{
    NSString *finalStr = [NSString string];
    NSMutableString * mutStr = [NSMutableString stringWithString:originUrl];
    NSArray *strArray = [mutStr componentsSeparatedByString:parameter];
    NSMutableString *firstStr = [strArray objectAtIndex:0];
    NSMutableString *lastStr = [strArray lastObject];
    NSRange characterRange = [lastStr rangeOfString:@"&"];
    
    if (characterRange.location !=NSNotFound) {
        NSArray *lastArray = [lastStr componentsSeparatedByString:@"&"];
        NSMutableArray *mutArray = [NSMutableArray arrayWithArray:lastArray];
        [mutArray removeObjectAtIndex:0];
        NSString *modifiedStr = [mutArray componentsJoinedByString:@"&"];
        finalStr = [[strArray objectAtIndex:0]stringByAppendingString:modifiedStr];
    } else {
        //以'?'、'&'结尾
        finalStr = [firstStr substringToIndex:[firstStr length] -1];
    }
    return finalStr;
}

+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param
{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}

#pragma mark JSON与NSString互转
+ (id)JSONValue:(NSString *)jsonString
{
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSData*)JSONString:(id)data
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

#pragma mark 正则校验

+ (BOOL)isValidatePassword:(NSString *)password
{
    if(password.length < 6 || password.length > 18){
        return NO;
    }
    return YES;
}

+ (BOOL)isValidateQQ:(NSString *)qq
{
    NSString *qqNumber = @"[1-9][0-9]\{4,14}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqNumber];
    return [qqTest evaluateWithObject:qq];
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobileNum
{
    NSString *phoneRegex = @"1[3|4|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}

+ (BOOL)isValidateCardAccount:(NSString *)cardNum
{
    if(cardNum.length == 16){
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 日期时间处理

+ (NSDateComponents *)getNSDateComponents
{
    return [self getNSDateComponentsByDate:[NSDate date]];
}

+ (NSDateComponents *)getNSDateComponentsByDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return components;
}

+ (NSInteger)getCurrentYear
{
    return [[self getNSDateComponents] year];
}

+ (NSInteger)getCurrentMonth
{
    return [[self getNSDateComponents] month];
}

+ (NSInteger)getCurrentDay
{
    return [[self getNSDateComponents] day];
}

+ (NSInteger)getCurrentYearByDate:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] year];
}

+ (NSInteger)getCurrentMonth:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] month];
}

+ (NSInteger)getCurrentDay:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] day];
}

+ (NSString *) compareCurrentTime:(double)inServerTime
{
    NSDate *compareDate = [NSDate dateWithTimeIntervalSince1970:inServerTime];
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"%@",NSLocalizedString(@"time_just", nil)];
    }
    else if ((temp = timeInterval/60) <60) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_minutes_ago", nil):NSLocalizedString(@"time_minute_ago", nil))];
    }
    
    else if ((temp = temp/60) <24) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_hours_ago", nil):NSLocalizedString(@"time_hour_ago", nil))];
    }
    
    else if ((temp = temp/24) <30) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_days_ago", nil):NSLocalizedString(@"time_day_ago", nil))];
    }
    
    else if ((temp = temp/30) <12) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_months_ago", nil):NSLocalizedString(@"time_month_ago", nil))];
    }
    else {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_years_ago", nil):NSLocalizedString(@"time_year_ago", nil))];
    }
    
    return  result;
}

+ (NSString *)getCountdownDay:(NSString *)targetDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:@"YYYY-MM-dd"];
    NSDate * newdate = [dm dateFromString:targetDate];
    long dd = [newdate timeIntervalSince1970] - (long)[datenow timeIntervalSince1970];
    
    NSString *timeString=@"0";
    if (dd/86400 >= 1) {
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
    }
    return timeString;
}


//格式化小数 四舍五入类型
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

#pragma mark APP配置
/**
 *  获取 APP 版本号
 *
 *  @return 版本号（格式为: 1.0.2）
 */
+ (NSString *)getAppFullVerion
{
    NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [appInfoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [appInfoDict objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@.%@", shortVersion, buildVersion];
}

+ (NSString *)networkingStatesFromStatebar
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";  // 没有网络
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";  // 比4G更快的蜂窝网
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
    }
    
    return stateString;
}

+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

+ (BOOL)IsEnableInternet
{
    if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable || [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable){
        return YES;
    }
    return NO;
}

+ (UIImage *)createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+ (NSString *)getCurrentRequestFromGetUrl:(NSString *)url
{
    NSString *result = @"";
    
    if([url containsString:@"?"]){
        NSArray *arr = [url componentsSeparatedByString:@"?"];
        
        if([arr[0] containsString:@"/"]){
            NSArray *prefixArr = [arr[0] componentsSeparatedByString:@"/"];
            
            result = prefixArr[prefixArr.count-1];
        }
    }
    else{
        if([url containsString:@"/"]){
            NSArray *prefixArr = [url componentsSeparatedByString:@"/"];
            
            result = prefixArr[prefixArr.count-1];
        }
    }
    
    return result;
}

+ (NSString *)getCurrentRequestFromPostUrl:(NSString *)url
{
    NSString *result = @"";
    
    if([url containsString:@"/"]){
        NSArray *prefixArr = [url componentsSeparatedByString:@"/"];
        
        result = prefixArr[prefixArr.count-1];
    }
        
    return result;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
