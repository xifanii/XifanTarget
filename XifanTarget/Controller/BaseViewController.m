//
//  BaseViewController.m
//  BaseProject
//
//  Created by 朱源浩 on 2017/3/14.
//  Copyright © 2017年 稀饭. All rights reserved.
//

#import "BaseViewController.h"
#import <UMMobClick/MobClick.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureData];
    
    [self initBaseUI];
    
    [self initUI];
    
    [self layoutUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initBaseUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initUI
{
    
}

- (void)layoutUI
{
    
}

- (void)configureData
{
    
}

- (void)gotoBack
{
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

- (void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number
{
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
    [MobClick event:eventId attributes:mutableDictionary];
}

- (void)addUmengEvent:(NSString *)eventId
{
    [MobClick event:eventId];
}

- (void)addUmengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes
{
    [MobClick event:eventId attributes:attributes];
}

@end
