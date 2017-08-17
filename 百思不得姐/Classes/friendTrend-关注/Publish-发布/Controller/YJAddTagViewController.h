//
//  YJAddTagViewController.h
//  百思不得姐
//
//  Created by 包宇津 on 16/5/10.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJAddTagViewController : UIViewController
//获取tags的block
@property (nonatomic,copy) void (^tagsBlock)(NSArray *tags);
//所有的标签
@property (nonatomic,strong) NSArray *tags;
@end
