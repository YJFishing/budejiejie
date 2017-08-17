//
//  YJTopic.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/2.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJTopicViewController.h"
@interface YJTopic : NSObject
/**ID*/
@property (nonatomic,copy) NSString *ID;
/**名称*/
@property (nonatomic,copy) NSString *name;
/**头像*/
@property (nonatomic,copy) NSString *profile_image;
/**发帖时间*/
@property (nonatomic,copy) NSString *create_time;
/**文字内容*/
@property (nonatomic,copy) NSString *text;
/*顶的数量*/
@property (nonatomic,assign) NSInteger ding;
/**踩得数量*/
@property (nonatomic,assign) NSInteger cai;
/**转发的数量*/
@property (nonatomic,assign) NSInteger repost;
/**评论的数量*/
@property (nonatomic,assign) NSInteger comment;
//是否是新浪加V用户
@property (nonatomic,assign,getter=isSina_v)BOOL sina_v;
//cell的高度
@property (nonatomic,assign) CGFloat cellHeight;
//图片的宽度
@property (nonatomic,assign) CGFloat width;
//图片的高度
@property (nonatomic,assign) CGFloat height;
//小图片的URL
@property (nonatomic,copy) NSString *small_image;
//大图片的URL
@property (nonatomic,copy) NSString *large_image;
//中图片的URL
@property (nonatomic,copy) NSString *middle_image;
//帖子类型
@property (nonatomic,assign) YJTopicType type;
//图片控件的frame
@property (nonatomic,assign,readonly) CGRect pictureFrame;
//声音控件的frame
@property (nonatomic,assign,readonly) CGRect voiceFrame;
//图片是否太大
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
//下载进度值
@property (nonatomic,assign) CGFloat downloadProgress;

//音频时长
@property (nonatomic,assign) NSInteger voicetime;
//视频时长
@property (nonatomic,assign) NSInteger videotime;
//播放次数
@property (nonatomic,assign) NSInteger playcount;
//视屏控件的frame
@property (nonatomic,assign,readonly) CGRect videoFrame;
//最热评论
@property (nonatomic,strong) NSArray *top_cmt;
@end
