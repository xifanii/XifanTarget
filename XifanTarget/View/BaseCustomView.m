//
//  BaseCustomView.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "BaseCustomView.h"
#import <UMMobClick/MobClick.h>

@implementation BaseCustomView

- (void)loadSubviews
{
    
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addUmengEvent:(NSString *)eventId
{
    [MobClick event:eventId];
}

@end
