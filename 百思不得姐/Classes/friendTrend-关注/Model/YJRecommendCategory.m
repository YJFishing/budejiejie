//
//  YJRecommendCategory.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/24.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRecommendCategory.h"

@implementation YJRecommendCategory
-(NSMutableArray *)users{
    if(!_users){
        _users=[NSMutableArray array];
    }
    return _users;
}
@end
