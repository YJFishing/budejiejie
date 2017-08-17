//
//  YJEssenceViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/22.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJEssenceViewController.h"
#import "YJRecommendTagsViewController.h"
#import "YJVideoViewController.h"
#import "YJAllViewController.h"
#import "YJVoiceViewController.h"
#import "YJWordViewController.h"
#import "YJPictureViewController.h"
@interface YJEssenceViewController()<UIScrollViewDelegate>
//标签栏底部的状态指示器
@property (nonatomic,strong) UIView *indicatorView;
//当前选中的按钮
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,weak) UIScrollView *contentView;
@property (nonatomic,weak) UIView *titlesView;
@end
@implementation YJEssenceViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    YJLog(@"%s",__func__);
    //设置导航栏内容
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    //设置导航栏左边的按钮
//    UIButton *tagButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    //不设置尺寸的按钮不会显示
//    tagButton.size=tagButton.currentBackgroundImage.size;
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
//    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
   
    
    [self setupNav];
     //初始化自控制器
    [self setupChildVc];
    [self setupContentView];
    [self setupTitlesView];
}
//初始化自控制器
-(void)setupChildVc{
    YJAllViewController *allView=[[YJAllViewController alloc]init];
    [self addChildViewController:allView];
    YJVideoViewController *video=[[YJVideoViewController alloc]init];
    [self addChildViewController:video];
    YJVoiceViewController *voice=[[YJVoiceViewController alloc]init];
    [self addChildViewController:voice];
    YJPictureViewController *picture=[[YJPictureViewController alloc]init];
    [self addChildViewController:picture];
    YJWordViewController *word=[[YJWordViewController alloc]init];
    [self addChildViewController:word];
}
//设置内容显示滚动条
-(void)setupContentView{
    //不自动调整inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *contentView=[[UIScrollView alloc]init];
    contentView.delegate=self;
//    contentView.backgroundColor=[UIColor redColor];
    contentView.frame=self.view.bounds;
    
//    UISwitch *s=[[UISwitch alloc]init];
//    s.y=800-s.height;
//    [contentView addSubview:s];
      contentView.contentSize=CGSizeMake(contentView.width*self.childViewControllers.count,0);
    contentView.pagingEnabled=YES;
    [self.view insertSubview:contentView atIndex:0];
  
    self.contentView=contentView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
//设置顶部的标签栏
-(void)setupTitlesView{
    UIView *titlesView=[[UIView alloc]init];
    titlesView.x=0;
    titlesView.y=YJTitleViewY;
    titlesView.width=self.view.width;
    titlesView.height=YJTitlesViewH;
    titlesView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    self.titlesView=titlesView;
    [self.view addSubview:titlesView];
    //设置标签
    NSArray *titles=@[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width=titlesView.width/titles.count;
    CGFloat height=titlesView.height;
    
    //底部的红色指示器
    self.indicatorView=[[UIView alloc]init];
    _indicatorView.backgroundColor=[UIColor redColor];
    _indicatorView.height=2;
    _indicatorView.tag=-1;
    _indicatorView.y=titlesView.height-_indicatorView.height;
    

    for(NSUInteger i=0;i<titles.count;i++){
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=i;
        btn.width=width;
        btn.height=height;
        btn.x=i*width;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        //不加这一句 标签下面的红线会不显示  label不会马上创建 width为0
        [btn layoutIfNeeded];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        if(i==0){//不直接调用[self titleClick:btn] 目的是一开始进来的时候没有动画
            btn.enabled=NO;
            self.selectedButton=btn;
            self.indicatorView.width=btn.titleLabel.width;
            self.indicatorView.centerX=btn.centerX;
        }
    }
    [titlesView addSubview:self.indicatorView];
}
-(void)titleClick:(UIButton *)btn{
    if(btn!=self.selectedButton){
        btn.enabled=NO;
        self.selectedButton.enabled=YES;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.width=btn.titleLabel.width;
        self.indicatorView.centerX=btn.centerX;
    }];
    self.selectedButton=btn;
       //滚动
    CGPoint offset=self.contentView.contentOffset;
    offset.x=btn.tag*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES ];
}
-(void)setupNav{
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}
-(void)tagClick{
    YJLog(@"侧边按钮被点击...");
    YJRecommendTagsViewController *vc=[[YJRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -<UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.width=self.selectedButton.titleLabel.width;
        self.indicatorView.centerX=self.selectedButton.centerX;
    }];

    //当前子控制器的View
    //当前的索引
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    //取出自控制器
    UIViewController *vc=self.childViewControllers[index];
    vc.view.x=scrollView.contentOffset.x;
    vc.view.y=0;//默认是20
    vc.view.height=scrollView.height;//默认是比屏幕高度少个20
    [scrollView addSubview:vc.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.width=self.selectedButton.titleLabel.width;
        self.indicatorView.centerX=self.selectedButton.centerX;
    }];
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
@end
