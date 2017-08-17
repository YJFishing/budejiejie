//
//  UIBarButtonItem+YJExtension.h
//  百思不得姐
//
//  Created by 包宇津 on 16/3/23.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
