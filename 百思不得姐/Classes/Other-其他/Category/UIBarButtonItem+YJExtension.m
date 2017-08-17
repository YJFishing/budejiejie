//
//  UIBarButtonItem+YJExtension.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/23.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "UIBarButtonItem+YJExtension.h"

@implementation UIBarButtonItem (YJExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *tabButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [tabButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tabButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [tabButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    tabButton.size=tabButton.currentBackgroundImage.size;
    return [[self alloc]initWithCustomView:tabButton];
}
@end
