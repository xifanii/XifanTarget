//
//  UIButton+CustomData.m
//  WanMeiZhiYuan
//
//  Created by Amon on 15/7/9.
//  Copyright (c) 2015年 iPin. All rights reserved.
//

#import "UIButton+CustomData.h"


@implementation UIButton (CustomData)

@dynamic customData;

static id customDataKey;


- (void) setCustomData:(id)customData
{
    objc_setAssociatedObject(self, &customDataKey, customData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)customData
{
    return objc_getAssociatedObject(self, &customDataKey);
}

@end
