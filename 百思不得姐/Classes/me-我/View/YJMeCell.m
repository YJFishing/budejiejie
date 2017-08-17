//
//  YJMeCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/3.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJMeCell.h"

@implementation YJMeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView=[[UIImageView alloc]init];
        bgView.image=[UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView=bgView;
        self.textLabel.textColor=[UIColor darkGrayColor];
        self.textLabel.font=[UIFont systemFontOfSize:16];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.imageView.image==nil) return;
    self.imageView.width=35;
    self.imageView.height=35;
    self.imageView.centerY=self.contentView.height*0.5;
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+10;
 
}
-(void)setFrame:(CGRect)frame{
//    frame.origin.y-=25;
    [super setFrame:frame];
    
}
@end
