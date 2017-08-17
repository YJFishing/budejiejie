//
//  YJTopicVoiceView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/16.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopicVoiceView.h"
#import "YJTopic.h"
#import "UIImageView+WebCache.m"
#import "YJShowPictureViewController.h"
@interface YJTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *voiceTime;


@end
@implementation YJTopicVoiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setTopic:(YJTopic *)topic{
    _topic=topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playCount.text=[NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute=topic.voicetime/60;
    NSInteger second=topic.voicetime%60;
    self.voiceTime.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
+(instancetype)voiceView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    self.autoresizingMask=UIViewAutoresizingNone;
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
