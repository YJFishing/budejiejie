//
//  YJSquareButton.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/5.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJSquareButton.h"
#import "YJSquare.h"
#import "UIButton+WebCache.h"
@implementation YJSquareButton
-(void)setUp{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:15];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self setUp];
    }
    return self;
}
-(void)awakeFromNib{
    [self setUp];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //调整图片
    self.imageView.y=self.height*0.15;
    self.imageView.width=self.width*0.5;
    self.imageView.height=self.imageView.width;
    self.imageView.centerX=self.width*0.5;
    
    //调整文字
    self.titleLabel.x=0;
    self.titleLabel.y=CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.titleLabel.y;
}
-(void)setSquare:(YJSquare *)square{
    _square=square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}
@end
