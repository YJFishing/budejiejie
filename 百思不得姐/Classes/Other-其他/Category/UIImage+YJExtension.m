//
//  UIImage+YJExtension.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/28.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "UIImage+YJExtension.h"

@implementation UIImage (YJExtension)
-(UIImage *)circleImage{
    //no代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获得上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //将图片画上去
    [self drawInRect:rect];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return image;
}
@end
