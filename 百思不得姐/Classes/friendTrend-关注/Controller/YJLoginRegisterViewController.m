//
//  YJLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/28.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJLoginRegisterViewController.h"

@interface YJLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *psd;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation YJLoginRegisterViewController
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    [self.view endEditing:YES];
    if(self.loginViewLeftMargin.constant==0){//显示注册界面
        self.loginViewLeftMargin.constant=-self.view.width;
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal];
    }else{
        self.loginViewLeftMargin.constant=0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view insertSubview:_bgView atIndex:0];
    //设置登录按钮边角半径
    self.loginButton.layer.cornerRadius=5;
    self.loginButton.layer.masksToBounds=YES;
    //设置注册按钮边角半径
    self.registerButton.layer.cornerRadius=5;
    self.registerButton.layer.masksToBounds=YES;
    
    //设置手机号文本框placeHolder文字颜色
//    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
//    NSAttributedString *placeHolder=[[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
//    self.phoneNum.attributedPlaceholder=placeHolder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//让状态栏显示为白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
