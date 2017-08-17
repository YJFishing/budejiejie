//
//  YJTextField.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/30.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTextField.h"
#import <objc/runtime.h>
@implementation YJTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)drawPlaceholderInRect:(CGRect)rect{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width,25) withAttributes:@{
//                                                                            NSForegroundColorAttributeName:[UIColor whiteColor],
//                                                                            NSFontAttributeName:self.font
//                                                                            }];
//}
/*
 运行时(Runtime)：
 苹果官方一套C语言库
 能做很多底层操作(比如访问隐藏的的一些成员变量/成员方法...)
 */
//+(void)initialize{
//    unsigned int count=0;
//    Ivar *ivars=class_copyIvarList([UITextField class], &count);
//    for(int i=0;i<count;i++){
//        Ivar ivar=*(ivars+i);
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    //释放
//    free(ivars);
//}
-(void)awakeFromNib{
    //设置光标颜色
    self.tintColor=self.textColor;
    [self resignFirstResponder];
}
-(BOOL)becomeFirstResponder{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
