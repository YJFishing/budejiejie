//
//  YJTopicVideoView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/16.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopicVideoView.h"
#import "YJTopic.h"
#import "UIImageView+WebCache.h"
@interface YJTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation YJTopicVideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)videoView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    self.autoresizingMask=UIViewAutoresizingNone;
}
-(void)setTopic:(YJTopic *)topic{
    _topic=topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text=[NSString stringWithFormat:@"%zd播放",topic.playcount];
    //时长
    NSInteger minute=topic.videotime/60;
    NSInteger second=topic.videotime%60;
    self.videotimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
