//
//  UITabBar+Badge.h
//  WanMeiZhiYuan
//
//  Created by Amon on 16/6/16.
//  Copyright © 2016年 iPIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

//  显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index;

//  隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end
