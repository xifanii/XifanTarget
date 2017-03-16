//  ViewController基类
//  BaseViewController.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>


@interface BaseViewController : UIViewController


/**
 *  加载数据
 */
- (void)configureData;

/**
 *  加载默认UI
 */
- (void)initBaseUI;

/**
 *  加载视图
 */
- (void)initUI;

/**
 *  加载视图布局
 */
- (void)layoutUI;

/**
 *  点击返回上层界面
 */
- (void)gotoBack;

/**
 *  判断当前ViewController是否已显示
 */
- (BOOL)isVisible;


/**
 *  添加友盟埋点
 *
 *  @param eventId 事件ID
 */
- (void)addUmengEvent:(NSString *)eventId;

- (void)addUmengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes;

- (void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number;


@end
