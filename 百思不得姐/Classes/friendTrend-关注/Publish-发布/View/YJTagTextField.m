//
//  YJTagTextField.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/12.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTagTextField.h"

@implementation YJTagTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)deleteBackward{
   
    !self.deleteBlock?:self.deleteBlock();
     [super deleteBackward];
}
@end
