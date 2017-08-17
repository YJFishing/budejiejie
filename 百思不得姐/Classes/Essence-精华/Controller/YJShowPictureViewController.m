//
//  YJShowPictureViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/11.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJShowPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"
@interface YJShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (nonatomic,weak) UIImageView *imageView;
@end

@implementation YJShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.userInteractionEnabled=YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    
    CGFloat screenW=[[UIScreen mainScreen]bounds].size.width;
    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
    
    CGFloat pictureW=screenW;
    CGFloat pictureH=pictureW*self.topic.height/self.topic.width;
    
    if(pictureH>screenH){//图片显示高度超过一个屏幕，需要滚动查看
        imageView.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize=CGSizeMake(0, pictureH);
    }else{
        imageView.size=CGSizeMake(pictureW, pictureH);
        imageView.centerY=screenH*0.5;
    }
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [self.progressView setProgress:self.topic.downloadProgress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        
        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%d%%",(int)(1.0*receivedSize/expectedSize*100)];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
    self.imageView=imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    if(self.imageView.image==nil){
        [SVProgressHUD showErrorWithStatus:@"图片未下载完毕"];
        return;
    }
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
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
