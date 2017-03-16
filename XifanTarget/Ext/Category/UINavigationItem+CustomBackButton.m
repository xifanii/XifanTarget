//
//  UINavigationItem.m
//  WanMeiZhiYuan
//
//  Created by 朱源浩 on 16/1/15.
//  Copyright © 2016年 iPIN. All rights reserved.
//

#import "UINavigationItem+CustomBackButton.h"

@implementation UINavigationItem (CustomBackButton)

- (UIBarButtonItem *)backBarButtonItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    return backItem;
}

@end
