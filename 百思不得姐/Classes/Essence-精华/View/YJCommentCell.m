//
//  YJCommentCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/25.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJCommentCell.h"
#import "YJComment.h"
#import "YJUser.h"
#import "UIImageView+WebCache.h"
#import "YJConst.h"
@interface YJCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end
@implementation YJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *backView=[[UIImageView alloc]init];
    backView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=backView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComment:(YJComment *)comment{
    _comment=comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"]circleImage]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image=[image circleImage];
    }];
    self.sexView.image=[comment.user.sex isEqualToString:YJUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text=comment.content;
    self.usernameLabel.text=comment.user.username;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%zd",comment.like_count];
    
    if(comment.voiceuri.length){
        self.voiceButton.hidden=NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden=YES;
    }
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    frame.origin.x=10;
    frame.size.width-=2*10;
}
#pragma mark -MenuController处理
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}
@end
