//
//  YJAddTagViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/10.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJAddTagViewController.h"
#import "YJConst.h"
#import "YJTagButton.h"
#import "YJTagTextField.h"
#import <SVProgressHUD.h>
#define screenH [[UIScreen mainScreen]bounds].size.height
#define screenW [[UIScreen mainScreen]bounds].size.width
@interface YJAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic,weak) UIView *contentView;
//文本输入框
@property (nonatomic,weak) YJTagTextField *textField;
@property (nonatomic,weak) UIButton *addButton;
//所有的标签按钮
@property (nonatomic,strong) NSMutableArray *tagButtons;
@end

@implementation YJAddTagViewController
-(NSMutableArray *)tagButtons{
    if(_tagButtons==nil){
        _tagButtons=[NSMutableArray array];
    }
    return _tagButtons;
}
-(UIButton *)addButton{
    if(_addButton==nil){
        UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:addButton];
        addButton.width=self.contentView.width;
        addButton.height=35;
        addButton.backgroundColor=[UIColor colorWithRed:74/255.0 green:139/255.0 blue:209/255.0 alpha:1.0];
        [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //加一些内边距
        addButton.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 10);
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        addButton.titleLabel.font=[UIFont systemFontOfSize:14];
        _addButton=addButton;
    }
    return _addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUpContentView];
    [self setUpTextField];
    [self setupTags];
}
-(void)setupTags{
    for(NSString *tag in self.tags){
        self.textField.text=tag;
        [self addBtnClick];
    }
}
-(void)setUpNav{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"添加标签";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
-(void)setUpContentView{
//    CGFloat screenW=[[UIScreen mainScreen]bounds].size.width;
//    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
    UIView *contentView=[[UIView alloc]init];
    contentView.x=10;
    contentView.width=screenW-20;
    contentView.height=screenH;
    contentView.y=10+44;
//    contentView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:contentView];
    self.contentView=contentView;
}
-(void)setUpTextField{
    __weak typeof (self) weakSelf=self;
    YJTagTextField *textField=[[YJTagTextField alloc]init];
    textField.delegate=self;
    textField.deleteBlock=^{
        YJLog(@"点击删除按钮");
        if(weakSelf.textField.hasText) return;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    textField.placeholder=@"多个标签用逗号或者换行隔开";
    textField.width=screenW;
    textField.height=25;
    [textField becomeFirstResponder];
    //textField不要用代理方法来监听文字的改变
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField=textField;
}
/**
 *  监听文字改变
 */
-(void)textDidChange{
    YJLog(@"%s",__func__);
    if(self.textField.hasText){//有文字
        //显示添加标签按钮
        self.addButton.hidden=NO;
        self.addButton.y=CGRectGetMaxY(self.textField.frame)+YJTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        //获取最后一个字符
        NSString *text=self.textField.text;
        NSUInteger len=text.length;
        NSString *lastLetter=[text substringFromIndex:len-1];
        YJLog(@"%@",lastLetter);
        if([lastLetter isEqualToString:@","]||[lastLetter isEqualToString:@"，"]){
            //去除逗号
            self.textField.text=[text substringToIndex:len-1];
            [self addBtnClick];
        }
    }else{//没有文字
        self.addButton.hidden=YES;
    }
    //更新标签和文本框的frame
    [self updateTagButtonFrame];
}
-(void)done{
    YJLog(@"%s",__func__);
    //传递数据给上一个控制器
    NSMutableArray *tags=[NSMutableArray array];
    for(YJTagButton *tagBtn in self.tagButtons){
        [tags addObject:tagBtn.currentTitle];
    }
    !self.tagsBlock?:self.tagsBlock(tags);
    YJLog(@"%@",tags);
    //关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  监听添加标签按钮点击
 */
-(void)addBtnClick{
    YJLog(@"%s",__func__);
    if(self.tagButtons.count==5){
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeBlack];
        return;
    }
    //添加一个标签按钮
    YJTagButton *tagButton=[YJTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    
    
//    [tagButton sizeToFit];
     tagButton.height=self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    //清空textfield文字
    self.textField.text=nil;
    self.addButton.hidden=YES;
}
/**
 *专门用来更新标签按钮的frame
 */
-(void)updateTagButtonFrame{
    for(int i=0;i<self.tagButtons.count;i++){
        YJTagButton *tagBtn=self.tagButtons[i];
        if(i==0){//最前面的标签按钮
            tagBtn.x=0;
            tagBtn.y=0;
        }else{//其他标签按钮
            YJTagButton *lastTagBtn=self.tagButtons[i-1];
            //计算当前行剩余的宽度
            CGFloat leftWidth=self.contentView.width-CGRectGetMaxX(lastTagBtn.frame)-YJTagMargin;
            if(leftWidth>=tagBtn.width){//按钮显示在当前行
                tagBtn.x=CGRectGetMaxX(lastTagBtn.frame)+YJTagMargin;
                tagBtn.y=lastTagBtn.y;
            }else{//按钮显示在下一行
                tagBtn.x=0;
                tagBtn.y=CGRectGetMaxY(lastTagBtn.frame)+YJTagMargin;
            }
        }
    }
    //更新textfield的frame
    YJTagButton *lastTagButton=[self.tagButtons lastObject];
    if(self.contentView.width-CGRectGetMaxX(lastTagButton.frame)-YJTagMargin>=[self textFieldTextWidth]){
        self.textField.y=lastTagButton.y;
        self.textField.x=CGRectGetMaxX(lastTagButton.frame)+YJTagMargin;
    }else{
        self.textField.x=0;
        self.textField.y=CGRectGetMaxY(lastTagButton.frame)+YJTagMargin;
    }
}
/**
 *  标签按钮的的点击
 */
-(void)tagButtonClick:(YJTagButton *)button{
    [button removeFromSuperview];
    [self.tagButtons removeObject:button];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}
-(CGFloat)textFieldTextWidth{
    CGFloat width=[self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, width);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -<UITextFieldDelegate>
/**
 *  监听键盘最右下角按钮的点击
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.textField.hasText){
        [self addBtnClick];
    }
    return YES;
}
@end
