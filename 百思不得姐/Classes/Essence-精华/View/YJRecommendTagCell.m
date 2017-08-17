//
//  YJRecommendTagCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/26.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRecommendTagCell.h"
#import "YJRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface YJRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumLabel;
@end
@implementation YJRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
-(void)setRecommendTag:(YJRecommendTag *)recommendTag{
    _recommendTag=recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text=recommendTag.theme_name;
    NSString *subNumber=nil;
    if(recommendTag.sub_number<10000){
        subNumber=[NSString stringWithFormat:@"%ld人订阅",(long)recommendTag.sub_number];
    }else{
        subNumber=[NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    self.subNumLabel.text=subNumber;
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x=5;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];
}

@end
