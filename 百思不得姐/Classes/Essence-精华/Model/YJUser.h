//
//  YJUser.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/17.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJUser : NSObject
//用户名
@property (nonatomic,copy) NSString *username;
//性别
@property (nonatomic,copy) NSString *sex;
//头像
@property (nonatomic,copy) NSString *profile_image;
@end
