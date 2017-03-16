//
//  UILabel+CustomData.m
//  WanMeiZhiYuan
//
//  Created by Amon on 15/12/7.
//  Copyright © 2015年 iPIN. All rights reserved.
//

#import "UILabel+CustomData.h"

@implementation UILabel (CustomData)
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
