//
//  YJWebViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/6.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJWebViewController.h"
#import "NJKWebViewProgress.h"
@interface YJWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
//进度代理兑现
@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation YJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress=[[NJKWebViewProgress alloc]init];
    self.webView.delegate=self.progress;
    __weak typeof(self) weakSelf=self;
    self.progress.progressBlock=^(float progress){
        YJLog(@"%f",progress);
        weakSelf.progressView.progress=progress;
        if(progress==1.0){
            weakSelf.progressView.hidden=YES;
        }
    };
    self.progress.webViewProxyDelegate=self;
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForWard:(id)sender {
    [self.webView goForward];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackItem.enabled=webView.canGoBack;
    self.goForwardItem.enabled=webView.canGoForward;
}
@end
