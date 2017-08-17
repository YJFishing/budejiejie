//
//  YJTopicCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/4.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopicCell.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "YJTopicPictureView.h"
#import "YJTopicVoiceView.h"
#import "YJTopicVideoView.h"
#import "YJComment.h"
#import "YJUser.h"
@interface YJTopicCell()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *DingButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *CaiButton;
//分享
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *CommentButton;
//关注
@property (weak, nonatomic) IBOutlet UIButton *GuanZhuBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
//图片帖子中间的内容
@property (nonatomic,weak) YJTopicPictureView *pictureView;
//声音帖子中间的内容
@property (nonatomic,weak) YJTopicVoiceView *voiceView;
//视屏帖子中间的内容
@property (nonatomic,weak) YJTopicVideoView *videoView;
//评论内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
//评论父控件
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation YJTopicCell
-(YJTopicPictureView *)pictureView{
    if(_pictureView==nil){
        YJTopicPictureView *pictureView=[YJTopicPictureView pictureView];
        _pictureView=pictureView;
    }
    return _pictureView;
}
+(instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(YJTopicVoiceView *)voiceView{
    if(_voiceView==nil){
        YJTopicVoiceView *voiceView=[YJTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView=voiceView;
    }
    return _voiceView;
}
-(YJTopicVideoView *)videoView{
    if(_videoView==nil){
        YJTopicVideoView *videoView=[YJTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView=videoView;
    }
    return _videoView;
}
-(void)setTopic:(YJTopic *)topic{
    _topic=topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"]circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image=[image circleImage];
    }];
    self.nameLabel.text=topic.name;
//    self.createTimeLabel.text=topic.create_time;
    [self setupButtonTitle:self.DingButton count:topic.ding placeHolder:@"顶"];
    [self setupButtonTitle:self.CaiButton count:topic.cai placeHolder:@"踩"];
    [self setupButtonTitle:self.ShareButton count:topic.repost placeHolder:@"分享"];
    [self setupButtonTitle:self.CommentButton count:topic.comment placeHolder:@"评论"];
    [self testDate:topic.create_time];
    
    //新浪加V
    self.sinaVView.hidden=!(topic.isSina_v);
    //显示文本
    self.text_Label.text=topic.text;
    
    if(topic.type==YJTopicTypePicture){//图片帖子
        self.pictureView.hidden=NO;
        self.pictureView.topic=topic;
        [self.contentView addSubview:_pictureView];
        _pictureView.frame=topic.pictureFrame;
        self.videoView.hidden=YES;
        self.voiceView.hidden=YES;
    }else if(topic.type==YJTopicTypeVoice){//声音帖子
        self.voiceView.hidden=NO;
        self.videoView.hidden=YES;
        self.pictureView.hidden=YES;
        self.voiceView.topic=topic;
        self.voiceView.frame=topic.voiceFrame;
    }else if(topic.type==YJTopicTypeVideo){//视屏帖子
        self.videoView.hidden=NO;
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
        self.videoView.topic=topic;
        self.videoView.frame=topic.videoFrame;
    }else {//段子帖子
        self.videoView.hidden=YES;
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
    }
    //处理评论
    YJComment *comment=[topic.top_cmt firstObject];
    if(comment){
        self.topCmtView.hidden=NO;
        self.topCmtContentLabel.text=[NSString stringWithFormat:@"%@:%@",comment.user.username,comment.content];
    }else{
        self.topCmtView.hidden=YES;
    }
}
-(void)testDate:(NSString *)create_time{
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //当前时间
    NSDate *now=[NSDate date];
    //发帖时间
    NSDate *create=[fmt dateFromString:create_time];
//    //日历
//    NSCalendar *calendar=[NSCalendar currentCalendar];
//    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//    NSDateComponents *cmpts=[calendar components:unit fromDate:createDate toDate:now options:0];
//    YJLog(@"%zd %zd %zd %zd %zd %zd",cmpts.year,cmpts.month,cmpts.day,cmpts.hour,cmpts.minute,cmpts.second);
    
    if(create.isThisYear){//今年
        if(create.isToday){//今天
            NSDateComponents *cmps=[[NSDate date] deltaFrom:create];
            if(cmps.hour>=1){//时间差距>=1小时
                self.createTimeLabel.text=[NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute>=1){//60分钟>时间差距>=1分钟
                self.createTimeLabel.text=[NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//小于1一分钟
                self.createTimeLabel.text=@"刚刚";
            }
        }else if(create.isYesterday){//昨天
            fmt.dateFormat=@"昨天 HH:mm:ss";
            self.createTimeLabel.text=[fmt stringFromDate:create];
        }else{//其他
            fmt.dateFormat=@"MM-dd HH:mm:ss";
            self.createTimeLabel.text=[fmt stringFromDate:create];
        }
    }else{//非今年
        self.createTimeLabel.text=create_time;
    }
    
    YJLog(@"%@",[now deltaFrom:create]);
}
-(void)setupButtonTitle:(UIButton *)btn count:(NSInteger)count placeHolder:(NSString *)placeholder{
    if(count==0){
        [btn setTitle:placeholder forState:UIControlStateNormal];
    }
    else if(count>10000){
        [btn setTitle:[NSString stringWithFormat:@"%.1f万",count/10000.0] forState:UIControlStateNormal];
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%zd",count] forState:UIControlStateNormal];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *backView=[[UIImageView alloc]init];
    backView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=backView;
    //设置头像为圆心图片 单用这种图层方式会比较卡
//    self.profileImageView.layer.cornerRadius=self.profileImageView.width*0.5;
//    self.profileImageView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x=10;
    frame.size.width-=2*frame.origin.x;
    frame.size.height=self.topic.cellHeight-1;
    frame.origin.y+=10;
    [super setFrame:frame];
}
- (IBAction)more:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报",nil];
    [sheet showInView:self.window];
}
@end
