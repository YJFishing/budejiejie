//
//  YJTagTextField.h
//  百思不得姐
//
//  Created by 包宇津 on 16/5/12.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTagTextField : UITextField
//按了删除键之后的回调
@property (nonatomic,copy) void (^deleteBlock)();
@end
