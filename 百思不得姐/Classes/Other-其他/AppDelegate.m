//
//  AppDelegate.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/21.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YJTabBarController.h"
#import "YJPushGuideView.h"
#import "YJTopWindow.h"
#import "YJConst.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口
    self.window=[[UIWindow alloc]init]; 
    self.window.frame=[[UIScreen mainScreen]bounds];
    //设置根控制器
    YJTabBarController *tabBarController=[[YJTabBarController alloc]init];
    self.window.rootViewController=tabBarController;
    tabBarController.delegate=self;
        //显示窗口
    [self.window makeKeyAndVisible];
//    //版本号
//    YJLog(@"%@",[[NSBundle mainBundle]infoDictionary][@"CFBundleShortVersionString"]);
//    //设置程序启动时的guide界面
//    YJPushGuideView *guideView=[YJPushGuideView guideView];
//    guideView.frame=self.window.bounds;
//    [self.window addSubview:guideView];
    
    
    //获得当前软件的版本号
    NSString *currentVersion=[[NSBundle mainBundle]infoDictionary][@"CFBundleShortVersionString"];
    //沙盒中版本号
    NSString *sanBoxVersion=[[NSUserDefaults standardUserDefaults]stringForKey:@"CFBundleShortVersionString"];
    if(![currentVersion isEqualToString:sanBoxVersion]){
        //显示引导界面
        YJPushGuideView *guideView=[YJPushGuideView guideView];
        guideView.frame=self.window.bounds;
        [self.window addSubview:guideView];
        //把当前版本存入沙盒
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    //添加一个window，点击这个window可以让scrollview滚到最顶部
    [YJTopWindow show];
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    for(UIWindow *window in windows) {
        
        if(window.rootViewController == nil){
            
            UIViewController* vc = [[UIViewController alloc]initWithNibName:nil bundle:nil];
            
            window.rootViewController = vc;
            
        }
        
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma -mark tabBarController代理方法
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    YJLog(@"%------@",viewController);
    //发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YJTabBarDidSelectNotification object:nil userInfo:nil];
}
@end
