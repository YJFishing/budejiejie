//
//  YJTopicPictureView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/9.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopicPictureView.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "YJConst.h"
#import "DALabeledCircularProgressView.h"
#import "YJShowPictureViewController.h"
@interface YJTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;



@end
@implementation YJTopicPictureView
+(instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)setTopic:(YJTopic *)topic{
    _topic=topic;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [self.progressView setProgress:topic.downloadProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress=1.0*receivedSize/expectedSize;
        self.progressView.hidden=NO;
        [self.progressView setProgress:progress animated:NO];
        //防止progress显示值为负数
        progress=(progress<0?0:progress);
        topic.downloadProgress=progress;
        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%d%%",(int)(progress*100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
        if(topic.isBigPicture==NO){
            return;
        }
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文
        CGFloat width=topic.pictureFrame.size.width;
        CGFloat height=width*image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
        
    }];
    //判断是否为gif
    NSString *extension=topic.large_image.pathExtension;
    self.gifView.hidden=![extension.lowercaseString isEqualToString:@"gif"];
   //判断是否显示"点击查看全图"
    if(topic.isBigPicture){//大图
        self.seeBigBtn.hidden=NO;
        self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    }else{  
        self.seeBigBtn.hidden=YES;
        self.imageView.contentMode=UIViewContentModeScaleToFill;
    }
}
-(void)awakeFromNib{
    self.autoresizingMask=UIViewAutoresizingNone;
    self.progressView.roundedCorners=2;
    self.progressView.progressLabel.textColor=[UIColor whiteColor];
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
-(void)showPicture{
    YJLog(@"%s----------- ",__func__);
    YJShowPictureViewController *pictureVC=[[YJShowPictureViewController alloc]init];
    pictureVC.topic=self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVC animated:YES completion:nil];
}
@end
