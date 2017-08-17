//
//  YJPlaceHolderTextView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/7.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJPlaceHolderTextView.h"
@interface YJPlaceHolderTextView()
@property (nonatomic,weak) UILabel *placeHolderLabel;
@end
@implementation YJPlaceHolderTextView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)updateSize{
    CGFloat screenW=[[UIScreen mainScreen]bounds].size.width;
    CGSize maxSize=CGSizeMake(screenW-2*self.placeHolderLabel.x, MAXFLOAT);
    self.placeHolderLabel.size=[self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=placeholder;
    self.placeHolderLabel.text=placeholder;
    [self updateSize];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor=placeholderColor;
    self.placeHolderLabel.textColor=placeholderColor;
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font=font;
    [self updateSize];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        
        //添加一个用来显示占位文字的label
        UILabel *placeHolderLabel=[[UILabel alloc]init];
        placeHolderLabel.numberOfLines=0;
        placeHolderLabel.x=4;
        placeHolderLabel.y=7;
        [self addSubview:placeHolderLabel];
        self.placeHolderLabel=placeHolderLabel;
        
        self.font=[UIFont systemFontOfSize:15];
        self.placeholderColor=[UIColor grayColor];
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical=YES;
        //监听文字改变
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
//监听文字改变
-(void)textDidChange{
    YJLog(@"%s",__func__);
    self.placeHolderLabel.hidden=self.hasText;
}
/**
 *  绘制占位文字 (每次调用drawRect之前，会自动清除掉之前绘制的内容)
 *
 */
//-(void)drawRect:(CGRect)rect{
//    //如果有文字，直接返回，不绘制占位文字
////    if(self.text.length||self.attributedText.length==0){
////        return;
////    }
//    if(self.hasText) return;
//    rect.origin.x=4;
//    rect.origin.y=7;
//    rect.size.width-=2*rect.origin.x;
//    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName]=self.font;
//    attrs[NSForegroundColorAttributeName]=self.placeholderColor;
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.placeHolderLabel.width=self.width-2*self.placeHolderLabel.x;
//    self.placeHolderLabel.height=self.height;
//}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
