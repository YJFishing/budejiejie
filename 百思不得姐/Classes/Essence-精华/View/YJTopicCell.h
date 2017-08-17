//
//  YJTopicCell.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/4.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTopic;
@interface YJTopicCell : UITableViewCell
/**
 *  帖子数据
 */
@property (nonatomic,strong) YJTopic *topic;
+(instancetype)cell;
@end
