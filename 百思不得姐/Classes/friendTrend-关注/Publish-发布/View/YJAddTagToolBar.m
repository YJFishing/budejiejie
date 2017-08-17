//
//  YJAddTagToolBar.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/9.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJAddTagToolBar.h"
#import "YJAddTagViewController.h"
#import "YJConst.h"
@interface YJAddTagToolBar()
@property (weak, nonatomic) IBOutlet UIView *topView;
//存放所有标签的label
@property (nonatomic,strong) NSMutableArray *tagLabels;
//添加按钮
@property (nonatomic,weak) UIButton *addButton;
@end
@implementation YJAddTagToolBar

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSMutableArray *)tagLabels{
    if(_tagLabels==nil){
        _tagLabels=[NSMutableArray array];
    }
    return _tagLabels;
}
+(instancetype)toolBar{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    UIButton *addButton=[[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size=addButton.currentImage.size;
    addButton.x=YJTagMargin;
    [self.topView addSubview:addButton];
    self.addButton=addButton;
    
    //默认就拥有两个标签
    [self createTags:@[@"吐槽",@"糗事"]];
}
-(void)addButtonClick{
    YJLog(@"%s",__func__);
    YJAddTagViewController *vc=[[YJAddTagViewController alloc]init];
    __weak typeof (self) weakSelf=self;
    [vc setTagsBlock:^(NSArray *tags) {
        [weakSelf createTags:tags];
    }];
    vc.tags=[self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root=[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav=(UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}
/**
 *  创建标签
 */
-(void)createTags:(NSArray *)tags{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for(int i=0;i<tags.count;i++){
        UILabel *label=[[UILabel alloc]init];
        [self.tagLabels addObject:label];
        label.backgroundColor=[UIColor colorWithRed:71/255.0 green:137/255.0 blue:212/255.0 alpha:1.0];
        label.text=tags[i];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:14];
        [label sizeToFit];
        label.width+=2*YJTagMargin;
        label.height=25;
        [self.topView addSubview:label];
        //设置位置
        if(i==0){//最前面的标签按钮
            label.x=0;
            label.y=0;
        }else{//其他标签按钮
            UILabel *lastTagLabel=self.tagLabels[i-1];
            //计算当前行剩余的宽度
            CGFloat leftWidth=self.topView.width-CGRectGetMaxX(lastTagLabel.frame)-YJTagMargin;
            if(leftWidth>=label.width){//按钮显示在当前行
                label.x=CGRectGetMaxX(lastTagLabel.frame)+YJTagMargin;
                label.y=lastTagLabel.y;
            }else{//按钮显示在下一行
                label.x=0;
                label.y=CGRectGetMaxY(lastTagLabel.frame)+YJTagMargin;
            }
        }
        
    }
    //加号按钮
    UILabel *lastTagLabel=[self.tagLabels lastObject];
    CGFloat leftWidth=CGRectGetMaxX(lastTagLabel.frame)+YJTagMargin;
    //更新frame
    if(self.topView.width-leftWidth>=self.addButton.width){
        self.addButton.x=leftWidth;
        self.addButton.y=lastTagLabel.y;
    }else{
        self.addButton.x=0;
        self.addButton.y=CGRectGetMaxY(lastTagLabel.frame)+YJTagMargin;
    }
    //整体的高度
    CGFloat oldH=self.height;
    self.height=CGRectGetMaxY(self.addButton.frame)+45;
    self.y-=self.height-oldH;
}
@end
