//
//  UITabBar+Badge.m
//  WanMeiZhiYuan
//
//  Created by Amon on 16/6/16.
//  Copyright © 2016年 iPIN. All rights reserved.
//

#import "UITabBar+Badge.h"

static const NSInteger kTabbarItemCount = 3;
@implementation UITabBar (Badge)

- (void)showBadgeOnItemIndex:(NSInteger)index
{
    
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = 888+index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    
    CGRect tabFrame = self.frame;
    float percentX = (index + 0.6) / kTabbarItemCount;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(NSInteger)index
{
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index
{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end
