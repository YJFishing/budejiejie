//
//  YJMeViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/22.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJMeViewController.h"
#import "YJMeCell.h"
#import "YJMeFooterView.h"
#import "YJSettingViewController.h"
@implementation YJMeViewController
static NSString *YJMeID=@"me";
-(void)viewDidLoad{
    [super viewDidLoad];
    YJLog(@"%s",__func__);
    //设置导航栏标题
    self.navigationItem.title=@"我的";
    //设置导航栏右侧两个按钮
//    UIButton *settingButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
//    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
//    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    settingButton.size=settingButton.currentBackgroundImage.size;
//    
//    UIButton *nightModeButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
//    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
//    nightModeButton.size=nightModeButton.currentBackgroundImage.size;
//    [nightModeButton addTarget:self action:@selector(nightModeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems=@[
                                              [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)],
                                              [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(nightModeButtonClick)]
                                              ];
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //去掉分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YJMeCell class] forCellReuseIdentifier:YJMeID];
    //调整footer和header
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=10;
    //调整inset
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //设置footview
    self.tableView.tableFooterView=[[YJMeFooterView alloc]init];
}
-(void)settingButtonClick{
    YJLog(@"我的设置按钮被点击...");
    [self.navigationController pushViewController:[[YJSettingViewController alloc]init] animated:YES];
    
}
-(void)nightModeButtonClick{
    YJLog(@"夜间模式按钮点击...");
}
#pragma mark- 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJMeCell *cell=[tableView dequeueReusableCellWithIdentifier:YJMeID];
    if(indexPath.section==0){
        cell.textLabel.text=@"登录/注册";
        cell.imageView.image=[UIImage imageNamed:@"setup-head-default"];
    }else if(indexPath.section==1){
        cell.textLabel.text=@"离线下载";
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
