//
//  YJTabBarController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/21.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJEssenceViewController.h"
#import "YJNewViewController.h"
#import "YJfriendTrendsViewController.h"
#import "YJMeViewController.h"
#import "YJTabBar.h"
#import "YJNavigationController.h"
@interface YJTabBarController()<UITabBarControllerDelegate>

@end
@implementation YJTabBarController
-(void)viewDidLoad{
    [super viewDidLoad];
    //通过appearance统一设置所有的UITabBarItem的文字属性
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    NSMutableDictionary *selectDict=[NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectDict[NSForegroundColorAttributeName]=[UIColor  darkGrayColor];
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];
    //添加子控制器
//    UIViewController *vc01=[[UIViewController alloc]init];
//    vc01.tabBarItem.title=@"精华";
//    vc01.tabBarItem.image=[UIImage imageNamed:@"tabBar_essence_icon"];
//    vc01.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_essence_click_icon"];
//    vc01.view.backgroundColor=[UIColor redColor];
//    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
//    dict[NSFontAttributeName]=[UIFont systemFontOfSize:12];
//    dict[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
//    [vc01.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    NSMutableDictionary *selectDict=[NSMutableDictionary dictionary];
//    selectDict[NSFontAttributeName]=[UIFont systemFontOfSize:12];
//    selectDict[NSForegroundColorAttributeName]=[UIColor  darkGrayColor];
//    [vc01.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [self addChildViewController:vc01];
//    
//    UIViewController *vc02=[[UIViewController alloc]init];
//    vc02.view.backgroundColor=[UIColor blackColor];
//    vc02.tabBarItem.title=@"新帖";
//    vc02.tabBarItem.image=[UIImage imageNamed:@"tabBar_new_icon"];
//    vc02.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_new_click_icon"];
//    [vc02.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    [vc02.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [self addChildViewController:vc02];
//    
//    UIViewController *vc03=[[UIViewController alloc]init];
//    vc03.tabBarItem.title=@"关注";
//    vc03.tabBarItem.image=[UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc03.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    vc03.view.backgroundColor=[UIColor greenColor];
//    [vc03.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    [vc03.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [self addChildViewController:vc03];
//    
//    UIViewController *vc04=[[UIViewController alloc]init];
//    vc04.tabBarItem.title=@"我";
//    vc04.tabBarItem.image=[UIImage imageNamed:@"tabBar_me_icon"];
//    vc04.tabBarItem.selectedImage=[UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc04.view.backgroundColor=[UIColor blueColor];
//    [vc04.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    [vc04.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [self addChildViewController:vc04];
    
    //添加自控制器
    [self setUpChildVc:[[YJEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc: [[YJNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:[[YJfriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:[[YJMeViewController alloc]initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
  
    //更换tabBar
    [self setValue:[[YJTabBar alloc]init] forKeyPath:@"tabBar"];
    self.delegate=self;
    
}
-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"%@",self.tabBar.subviews);
}
-(void)setUpChildVc:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    VC.tabBarItem.title=title;
    VC.navigationItem.title=title;
    VC.tabBarItem.image=[UIImage imageNamed:image];
    VC.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
//    VC.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //添加一个导航控制器，添加导航控制器为tabBarController的子控制器
    YJNavigationController *nav=[[YJNavigationController alloc]initWithRootViewController:VC];
   
    [self addChildViewController:nav];
}

@end
