//
//  YJTopWindow.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/27.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopWindow.h"
#import "UIView+Extension.h"
@implementation YJTopWindow
//类方法不能用成员变量
static UIWindow *window_;
+(void)show{
   
    window_.hidden=NO;
}
+ (void)initialize
{
    window_=[[UIWindow alloc]init];
    window_.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 20);
    window_.windowLevel=UIWindowLevelAlert;
    window_.backgroundColor=[UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}
//监听窗口点击
+(void)windowClick{
    YJLog(@"%s",__func__);
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+(void)searchScrollViewInView:(UIView *)superView{
    for(UIScrollView *view in superView.subviews){
//        //转化坐标系 nil默认窗口作为坐标系  得到subView在窗口中的frame
//        CGRect newFrame=[view.superview convertRect:view.frame toView:nil];
//        CGRect winBounds=[UIApplication sharedApplication].keyWindow.bounds;
//        //CGRectIntersectsRect用来判断两个控件有没有交界 在同一个坐标系里才具有可比性
//        BOOL isShowingOnWindow=!view.isHidden&&view.alpha>0.01&&CGRectIntersectsRect(newFrame, winBounds);
        //如果是scrollView滚动到最顶部
        if([view isKindOfClass:[UIScrollView class]]&&[view isShowingOnKeyWindow]){
            CGPoint offset=view.contentOffset;
            offset.y=-view.contentInset.top;
            [view setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:view];
    }
}
@end
