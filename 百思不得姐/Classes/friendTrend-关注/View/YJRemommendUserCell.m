//
//  YJRemommendUserCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/25.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRemommendUserCell.h"
#import "YJRecommendUser.h"
#import "UIImageView+WebCache.h"
@interface YJRemommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end
@implementation YJRemommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUser:(YJRecommendUser *)user{
    _user=user;
    self.screenNameLabel.text=user.screen_name;
    self.fansCountLabel.text=[NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
