//
//  YJTagButton.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/12.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTagButton.h"
#import "YJConst.h"
@implementation YJTagButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.backgroundColor=[UIColor colorWithRed:74/255.0 green:139/255.0 blue:209/255.0 alpha:1.0];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self .titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width+=3*YJTagMargin;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x=YJTagMargin;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+YJTagMargin;
}
@end
