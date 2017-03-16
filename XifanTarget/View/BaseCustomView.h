//  自定义视图基类
//  BaseCustomView.h
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "CommonMacro.h"
#import <Masonry.h>
#import <UIKit/UIKit.h>

@interface BaseCustomView : UIView

- (void)loadSubviews;

- (void)addUmengEvent:(NSString *)eventId;

@end
