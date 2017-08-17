//
//  YJPublishViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/12.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJPublishViewController.h"
#import "YJVerticalButton.h"
#import "POP.h"
#import "POPSpringAnimation.h"

static CGFloat const POPAnimationDelay=0.1;
@interface YJPublishViewController ()
@end

@implementation YJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //让控制器的view不能被点击
    self.view.userInteractionEnabled=NO;
    
    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
    CGFloat screenW=[[UIScreen mainScreen]bounds].size.width;
    CGFloat buttonStartY=(screenH-2*72)*0.5;
    
    //数据
    NSArray *images=@[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles=@[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //添加6个按钮
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+30;
    int maxCols=3;
    CGFloat buttonStartX=30;
    CGFloat xMargin=(screenW-3*buttonW-2*buttonStartX)/(maxCols-1);
    for(int i=0;i<6;i++){
        YJVerticalButton *btn=[[YJVerticalButton alloc]init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        int row=i/maxCols;
        int col=i%maxCols;
        //        btn.width=buttonW;
        //        btn.height=buttonH;
        //        btn.x=buttonStartX+col*(buttonW+xMargin);
        //        btn.y=buttonStartY+row*buttonH;
        CGFloat buttonX=buttonStartX+col*(buttonW+xMargin);
        CGFloat buttonEndY=buttonStartY+row*buttonH;
        
        CGFloat buttonStartY=buttonEndY-screenH;
        [self.view addSubview:btn];
        
        //添加动画
        POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue=[NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
        anim.toValue=[NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness=10;
        anim.springSpeed=10;
        anim.beginTime=CACurrentMediaTime()+POPAnimationDelay*i;
        [btn pop_addAnimation:anim forKey:nil];
        
    }
    //添加标语
    UIImageView *sloganView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX=screenW*0.5;
    CGFloat centerEndY=screenH*0.2;
    CGFloat centerBeginY=centerEndY-screenH;
    anim.beginTime=CACurrentMediaTime()+images.count*POPAnimationDelay;
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springSpeed=10;
    anim.springBounciness=10;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //动画执行完毕，恢复点击事件
        self.view.userInteractionEnabled=YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
-(void)btnClick:(UIButton *)btn{
    YJLog(@"%ld",btn.tag);
//    if(btn.tag==0){
//        YJLog(@"发视频");
//    }
    [self cancelWithCompletionBlock:^{
        if(btn.tag==2){
            YJLog(@"发段子");
        }
    }];
}
/**
 *  先执行退出动画，然后执行completionBlock中的方法
 */
-(void)cancelWithCompletionBlock:(void(^)())completionBlock{
    self.view.userInteractionEnabled=NO;
    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
    YJLog(@"%@",self.view.subviews);
    for(int i=2;i<self.view.subviews.count;i++){
        UIView *subView=self.view.subviews[i];
        POPBasicAnimation *anim=[POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(subView.centerX, subView.centerY+screenH)];
        anim.beginTime=CACurrentMediaTime()+(i-2)*POPAnimationDelay;
        
//        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//            [self dismissViewControllerAnimated:NO completion:nil];
//            if(completionBlock){
//                completionBlock();
//            }
//        }];
        //最后一个动画
                if(i==self.view.subviews.count-4){
                    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                        [self dismissViewControllerAnimated:NO completion:nil];
                        if(completionBlock){
                            completionBlock();
                        }
                    }];
                }
        [subView pop_addAnimation:anim forKey:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel {
//    self.view.userInteractionEnabled=NO;
//    CGFloat screenH=[[UIScreen mainScreen]bounds].size.height;
//    YJLog(@"%@",self.view.subviews);
//    for(int i=2;i<self.view.subviews.count;i++){
//        UIView *subView=self.view.subviews[i];
//        POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(subView.centerX, subView.centerY+screenH)];
//        anim.beginTime=CACurrentMediaTime()+(i-2)*POPAnimationDelay;
//        anim.springBounciness=10;
//        anim.springSpeed=10;
//        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//            [self dismissViewControllerAnimated:NO completion:nil];
//        }];
//        //最后一个动画
////        if(i==self.view.subviews.count-4){
////            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
////                [self dismissViewControllerAnimated:NO completion:nil];
////            }];
////        }
//        [subView pop_addAnimation:anim forKey:nil];
//    }
    [self cancelWithCompletionBlock:nil];
}

/*
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation,是基于CADisplayLink
 4.Core Animation动画仅仅是表象 并不会修改对象的具体数据frame/size等
 5.pop动画会修改控件的属性
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //view的动画
    //    POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    //    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
    //
    //    anim.springBounciness=20;
    //    anim.springSpeed=20;
    //    [self.sloganView pop_addAnimation:anim forKey:nil];
    
    //layer的动画
    //    POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //    anim.fromValue=@(self.sloganView.layer.position.y);
    //    anim.toValue=@(300);
    //    anim.springSpeed=20;
    //    anim.springBounciness=20;
    //    anim.beginTime=CACurrentMediaTime()+2.0;
    //    anim.completionBlock=^(POPAnimation *anim,BOOL finished){
    //        YJLog(@"动画结束");
    //    };
    //    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
    
    [self cancel];
}
@end
