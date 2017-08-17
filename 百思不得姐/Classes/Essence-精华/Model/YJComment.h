//
//  YJComment.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/17.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJUser;
@interface YJComment : NSObject
//音频文件的时长
@property (nonatomic,assign) NSInteger voicetime;
//评论的文字内容
@property (nonatomic,copy) NSString *content;
//被点赞的数量
@property (nonatomic,assign) NSInteger like_count;
//用户
@property (nonatomic,strong) YJUser *user;
//音频文件的路径
@property (nonatomic,copy) NSString *voiceuri;
@property (nonatomic,copy) NSString *ID;
@end
