//
//  YJNewViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/22.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJNewViewController.h"

@implementation YJNewViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    YJLog(@"%s",__func__);
//    UIButton *tabButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [tabButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [tabButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    [tabButton addTarget:self action:@selector(tabButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    tabButton.size=tabButton.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tabButtonClick)];
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
}
-(void)tabButtonClick{
    YJLog(@"按钮点击了...");
}
@end
