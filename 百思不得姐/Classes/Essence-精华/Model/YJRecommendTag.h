//
//  YJRecommendTag.h
//  百思不得姐
//
//  Created by 包宇津 on 16/3/26.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRecommendTag : NSObject
//图片
@property (nonatomic,copy) NSString *image_list;
//名称
@property (nonatomic,copy) NSString *theme_name;
//订阅数
@property (nonatomic,assign) NSInteger sub_number;
@end
