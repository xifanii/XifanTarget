//  自定义返回按钮，以解决返回按钮触摸范围过大的问题
//  UIViewController+CustomBackButton.h
//  WanMeiZhiYuan
//
//  Created by Amon on 17/1/3.
//  Copyright © 2017年 iPIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskView : UIView

@property (nonatomic, strong) UIButton *backButton;

@end

@interface UIViewController (CustomBackButton)

- (void)customNavBackButtonMethod;

@end
