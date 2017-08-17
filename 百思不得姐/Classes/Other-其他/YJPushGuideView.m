//
//  YJPushGuideView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/31.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJPushGuideView.h"

@implementation YJPushGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)guideView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject] ;
}
- (IBAction)close {
    [self removeFromSuperview];
}
@end
