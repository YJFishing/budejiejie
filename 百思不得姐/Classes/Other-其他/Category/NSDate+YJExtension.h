//
//  NSDate+YJExtension.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/4.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJExtension)
/**
 *  比较from和self的时间差值
 */
-(NSDateComponents *)deltaFrom:(NSDate *)from;
//是否为今年
-(BOOL)isThisYear;
//是否今天
-(BOOL)isToday;
//是否昨天
-(BOOL)isYesterday;
@end
