//
//  YJTopicVideoView.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/16.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTopic;
@interface YJTopicVideoView : UIView
@property (nonatomic,strong) YJTopic *topic;
+(instancetype)videoView;
@end
