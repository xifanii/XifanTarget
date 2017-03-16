//
//  CommonMacro.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#import "Constants.h"
#import "APIConfig.h"
#import "ToolsUtil.h"

#if TARGET_IPHONE_SIMULATOR
#define isSimulator YES
#else
#define isSimulator NO
#endif

/*
    iOS版本判断
 */
///  判断设备版本是否是iOS8
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

///  判断设备版本是否大于或等于某个版本
#define OS_VERSION_EG_TO(MajorVersion, MinorVersion, PatchVersion) [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){MajorVersion, MinorVersion, PatchVersion}]


/*
    屏幕适配
 */
///  标注基于iPhone6，计算屏幕与iPhone6屏幕的比例，进行适配
#define SCALE_OF_SCREEN ([[UIScreen mainScreen] bounds].size.width/375.)

#define MAXFONT(SIZE) (MAX(SIZE*SCALE_OF_IPHONE6_SCREEN, SIZE))
#define MINFONT(SIZE) (MIN(SIZE*SCALE_OF_IPHONE6_SCREEN, SIZE))

/////  尺寸自动基于iPhone6适配成实际大小
#define SCALE(v)              ((V)*([[UIScreen mainScreen] bounds].size.width/375.))

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


/*
    语言
 */
#define WeakSelf __weak typeof(self) weakSelf = self;
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;



/*
    综合
 */
///  自定义弹出框
#define showAlert(_msg) {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];[alert show];}

///  SVProgressHUD显示
//#define showHUDInfo(text) {\
//[self showHudInfo:text];\
//}


///  显示网络运行状态
#define showNetworkActivityIndicator(flag) {[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:flag];}

///  获取PNG文件
#define PNGIMAGEWITHFILE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]

///  获取JPG文件
#define JPGIMAGEWITHFILE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"]]

///  系统语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



/*
    视图相关
 */
/// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

///  RIGHTOF:    位于某个视图右侧，坐标为该视图的 x+width
///  BOTTEMOF:   位于某个视图下方，坐标为该视图的 y+height
#define RIGHTOF(v)              ((v).frame.origin.x + (v).frame.size.width)
#define BOTTEMOF(v)             ((v).frame.origin.y + (v).frame.size.height)
#define LEFTOF(v)               ((v).frame.origin.x)

#define HEIGHT_OF_NAVIGATION_BAR    self.navigationController.navigationBar.frame.size.height
#define HEIGHT_OF_STATUS_BAR        [[UIApplication sharedApplication] statusBarFrame].size.height
#define SIZE_OF_SCREEN    [[UIScreen mainScreen] bounds].size
#define HEIGHT_OF_TAB_BAR   49.f
#define HEIGHT_OF_TOP_BAR   64.f
#define HEIGHT_OF_TOOL_BAR   44.f

/// 文本
#define TEXTRECT(text, constraintSize, font) [text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font } context:nil]


/// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


///  View加边框
#define ViewBorder(View, BorderColor, BorderWidth )\
\
View.layer.borderColor = BorderColor.CGColor;\
View.layer.borderWidth = BorderWidth;

#define LayerRadius(Layer, Radius)\
\
[Layer setCornerRadius:(Radius)];\
[Layer setMasksToBounds:YES]

#define LayerBorder(Layer, BorderColor, BorderWidth )\
\
Layer.borderColor = BorderColor.CGColor;\
Layer.borderWidth = BorderWidth;

#define ViewRandomColor(View)\
\
View.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

///  RGB转UIColor
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define RGBCOLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

///  随机颜色
#define UIColorRandom [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


/// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]

/// 自定义字体
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#define FONT_CUSTOM(LEVEL, FONTSIZE)    [UIFont fontWithName:(LEVEL == 0 ? @"STHeitiSC-Light" : LEVEL == 1 ? @"STHeitiSC-Medium" : @"STHeitiSC-Bold") size:(FONTSIZE)]

//#define FONT_CUSTOM_SCALE(LEVEL, FONTSIZE)    [UIFont fontWithName:(LEVEL == 0 ? @"STHeitiSC-Light" : LEVEL == 1 ? @"STHeitiSC-Medium" : @"STHeitiSC-Bold") size:(MIN(FONTSIZE, FONTSIZE*SCALE_OF_IPHONE6_SCREEN))]

#define FONT_CUSTOM_SCALE(LEVEL, FONTSIZE)    LEVEL == 0 ? [UIFont systemFontOfSize:(MIN(FONTSIZE, FONTSIZE*SCALE_OF_IPHONE6_SCREEN))] : [UIFont boldSystemFontOfSize:(MIN(FONTSIZE, FONTSIZE*SCALE_OF_IPHONE6_SCREEN))]

#define FONT_XX    [UIFont systemFontOfSize:18]
#define FONT_X    [UIFont systemFontOfSize:14]
#define FONT_M    [UIFont systemFontOfSize:12]
#define FONT_S    [UIFont systemFontOfSize:10]


//  卡片圆角为4
#define CORNER_RADIUS_X 4
//  按钮圆角为3
#define CORNER_RADIUS_M 3

#define ViewBorderWidth  0.5
#define BorderWidthBar  1

//  通用 Bar 高度
#define MAIN_BAR_HEIGHT 38.f


//  系统主题颜色
#define APP_COLOR_               UIColorFromRGB(0xdcdcdc)
#define APP_COLOR_BLACK          UIColorFromRGB(0x333333)


#endif /* CommonMacro_h */
