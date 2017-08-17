//
//  YJTopic.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/2.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopic.h"
#import "YJComment.h"
#import "YJUser.h"
#import <MJExtension.h>
@implementation YJTopic{
//    CGRect _pictureFrame;
//    CGRect _voiceFrame;
}
-(CGFloat)cellHeight{
    if(!_cellHeight){
        YJLog(@"%--@,--%@,--%@",self.small_image,self.middle_image,self.large_image);
        CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-4*YJTopicCellMargin, MAXFLOAT);
        //    CGFloat textH=[topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //文字的最大尺寸
        CGFloat textH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的高度
        CGFloat cellH=YJTopicCellTextY+textH+YJTopicCellBottomBarH+2*YJTopicCellMargin;
        if(self.type==YJTopicTypePicture){//图片帖子
            CGFloat imageW=maxSize.width;
            CGFloat imageH=imageW*self.height/self.width;
            if(imageH>YJTopicCellPictureMaxH){
                imageH=YJTopicCellPictureBreakH;
                self.bigPicture=YES;
            }
            cellH+=imageH+10;
            CGFloat pictureY=YJTopicCellTextY+textH;
            _pictureFrame=CGRectMake(10, pictureY, imageW, imageH);
        }else if(self.type==YJTopicTypeVoice){//声音帖子
            CGFloat voiceX=YJTopicCellMargin;
            CGFloat voiceY=YJTopicCellTextY+textH+YJTopicCellMargin;
            CGFloat voiceW=maxSize.width;
            CGFloat voiceH=voiceW*self.height/self.width;
            _voiceFrame=CGRectMake(voiceX, voiceY, voiceW, voiceH);
           cellH+=voiceH;
        }else if(self.type==YJTopicTypeVideo){//视屏帖子
            CGFloat videoX=YJTopicCellMargin;
            CGFloat videoY=YJTopicCellTextY+textH+YJTopicCellMargin;
            CGFloat videoW=maxSize.width;
            CGFloat videoH=videoW*self.height/self.width;
            _videoFrame=CGRectMake(videoX, videoY, videoW, videoH);
            cellH+=videoH;
        }
        YJComment *cmt=[self.top_cmt firstObject];
        if(cmt){
            CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-4*YJTopicCellMargin, MAXFLOAT);
            NSString *content=[NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
            CGFloat contentH=[content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight=cellH+contentH+20;
        }else{
            _cellHeight=cellH;
        }
    }
    return _cellHeight;
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             @"ID":@"id"
             };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt":@"YJComment"};
}
@end
