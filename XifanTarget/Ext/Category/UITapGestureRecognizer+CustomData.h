//  自定义带参数数据的UITapGestureRecognizer
//  UITapGestureRecognizer+CustomData.h
//  WanMeiZhiYuan
//
//  Created by Amon on 15/7/9.
//  Copyright (c) 2015年 iPin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITapGestureRecognizer (CustomData)

@property (nonatomic, retain) id customData;

@end
