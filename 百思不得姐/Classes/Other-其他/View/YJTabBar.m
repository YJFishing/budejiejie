//
//  YJTabBar.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/22.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTabBar.h"
#import "YJPublishViewController.h"
@interface YJTabBar()
@property (nonatomic,weak) UIButton *publishButton;
@end
@implementation YJTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加中间的按钮
        UIButton *publishButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publishj_click_iocn"] forState:UIControlStateHighlighted];
        
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton=publishButton;
    }
    return self;
}
-(void)publishClick{
    YJPublishViewController *publishVC=[[YJPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置发布按钮的frame
//    self.publishButton.bounds=CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
//    self.publishButton.width=self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height=self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.size=self.publishButton.currentBackgroundImage.size;
    self.publishButton.center=CGPointMake(self.width*0.5, self.height*0.5);
    //设置其他TabBarButton的frame
    CGFloat buttonY=0;
    CGFloat buttonW=self.width/5;
    CGFloat buttonH=self.height;
    NSInteger index=0;
    for(UIView *button in self.subviews){
        if(![button isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        //计算按钮的x值
        CGFloat buttonX=buttonW*((index>1)?(index+1):index);
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
   
}
@end
