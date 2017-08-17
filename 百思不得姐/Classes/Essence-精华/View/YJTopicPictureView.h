//
//  YJTopicPictureView.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/9.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTopic;
@interface YJTopicPictureView : UIView
+(instancetype)pictureView;
//帖子数据
@property (nonatomic,strong) YJTopic *topic;
@end
