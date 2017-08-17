//
//  YJComment.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/17.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJComment.h"
#import "YJUser.h"
#import <MJExtension.h>
@implementation YJComment
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
