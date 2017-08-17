//
//  YJNavigationController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/23.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJNavigationController.h"

@implementation YJNavigationController
//当第一次使用这个类的时候会调用一次
+(void)initialize{
    //当导航栏用在YJNavigationController中appearance设置才会生效
    UINavigationBar *bar=[UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //设置字体大小
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    //设置颜色
    NSMutableDictionary *itemAttrs=[NSMutableDictionary dictionary];
    itemAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    itemAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    NSMutableDictionary *itemDisableAttrs=[NSMutableDictionary dictionary];
    itemDisableAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    itemDisableAttrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisableAttrs forState:UIControlStateDisabled];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置返回按钮颜色
//    self.navigationBar.tintColor=[UIColor blackColor];
//     [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
       if(self.childViewControllers.count>0){
           UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
           [button setTitle:@"返回" forState:UIControlStateNormal];
           [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
           [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
           [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
           button.size=CGSizeMake(100, 30);
           button.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
//           button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
           [button sizeToFit];
           [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
           viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
           //隐藏tabbar
           viewController.hidesBottomBarWhenPushed=YES;
    }
        [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
