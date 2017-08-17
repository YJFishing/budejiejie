//
//  YJPostWordViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/7.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJPostWordViewController.h"
#import "YJPlaceHolderTextView.h"
#import "YJAddTagToolBar.h"
@interface YJPostWordViewController ()<UITextViewDelegate>
//文本输入控件
@property (nonatomic,weak) YJPlaceHolderTextView *textView;
//工具条
@property (nonatomic,weak) YJAddTagToolBar *toolBar;
@end

@implementation YJPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUPNav];
    [self setUpTextView];
    [self setupToolBar];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView resignFirstResponder];
    [self.textView becomeFirstResponder];
}
-(void)setupToolBar{
    YJAddTagToolBar *toolBar=[YJAddTagToolBar toolBar];
    toolBar.width=self.view.width;
    toolBar.y=self.view.height-toolBar.height;
    self.toolBar=toolBar;
    [self.view addSubview:toolBar];
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
/**
 *  监听键盘的弹出和隐藏
 */
-(void)keyBoardWillChangeFrame:(NSNotification *)note{
    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
    CGRect keyBoardF=[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //动画时间
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform=CGAffineTransformMakeTranslation(0, keyBoardF.origin.y-screenH);
    }];
}
-(void)setUpTextView{
    YJPlaceHolderTextView *textView=[[YJPlaceHolderTextView alloc]init];
    textView.frame=self.view.bounds;
    textView.placeholder=@"把好玩的图片，段子发到这里，让大家都来乐一下。把好玩的图片，段子发到这里，让大家都来乐一下。把好玩的图片，段子发到这里，让大家都来乐一下。把好玩的图片，段子发到这里，让大家都来乐一下。把好玩的图片，段子发到这里，让大家都来乐一下。";
    textView.placeholderColor=[UIColor grayColor];
    textView.delegate=self;
    self.textView=textView;
    
    [self.view addSubview:textView];
}
-(void)setUPNav{
    self.title=@"发表文字";
//    self.view.backgroundColor=[UIColor blueColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}
-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)post{
    YJLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -<UITextViewDelegate>代理方法
-(void)textViewDidChange:(UITextView *)textView{
    YJLog(@"%s",__func__);
    self.navigationItem.rightBarButtonItem.enabled=textView.hasText;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
