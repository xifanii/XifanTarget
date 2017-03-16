//
//  UIWebView+JavaScriptAlert.h
//  WanMeiZhiYuan
//
//  Created by Amon on 16/8/31.
//  Copyright © 2016年 iPIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

@end
