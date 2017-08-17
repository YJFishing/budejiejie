//
//  YJfriendTrendsViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/22.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJfriendTrendsViewController.h"
#import "YJRecommendViewController.h"
#import "YJLoginRegisterViewController.h"
@implementation YJfriendTrendsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    YJLog(@"%s",__func__);
    //设置导航栏标题
    self.navigationItem.title=@"我的关注";
    //设置导航栏左边的按钮
//    UIButton *tagButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] forState:UIControlStateNormal];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] forState:UIControlStateHighlighted];
//    tagButton.size=tagButton.currentBackgroundImage.size;
//    [tagButton addTarget:self action:@selector(tagButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"tabBar_friendTrends_icon" highImage:@"tabBar_friendTrends_click_icon" target:self action:@selector(tagButtonClick)];
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
}
-(void)tagButtonClick{
    YJLog(@"关注侧边栏按钮被点击...");
    YJRecommendViewController *vc=[[YJRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegister {
   YJLoginRegisterViewController *login=[[YJLoginRegisterViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}

@end
