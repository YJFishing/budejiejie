//
//  YJRecommendUser.h
//  百思不得姐
//
//  Created by 包宇津 on 16/3/25.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJRecommendUser : NSObject
//头像
@property (nonatomic,copy) NSString *header;
//粉丝数
@property (nonatomic,assign) NSInteger fans_count;
//昵称
@property (nonatomic,copy) NSString *screen_name;
@end
