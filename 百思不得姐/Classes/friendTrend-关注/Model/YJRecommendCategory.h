//
//  YJRecommendCategory.h
//  百思不得姐
//
//  Created by 包宇津 on 16/3/24.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRecommendCategory : NSObject
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString *name;

//总数
@property (nonatomic,assign) NSInteger total;

//该类别包含的用户数据
@property (nonatomic,strong) NSMutableArray *users;
//当前页码
@property (nonatomic,assign) NSInteger currentPage;
@end
