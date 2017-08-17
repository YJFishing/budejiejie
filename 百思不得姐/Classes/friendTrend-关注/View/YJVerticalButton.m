//
//  YJVerticalButton.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/29.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJVerticalButton.h"

@implementation YJVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //调整图片位置
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.width;
    //设置文字
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.height;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.imageView.height;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}
@end
