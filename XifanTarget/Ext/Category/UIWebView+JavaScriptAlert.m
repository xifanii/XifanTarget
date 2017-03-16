//
//  UIWebView+JavaScriptAlert.m
//  WanMeiZhiYuan
//
//  Created by Amon on 16/8/31.
//  Copyright © 2016年 iPIN. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定",nil];
    [alert show];
}

@end
