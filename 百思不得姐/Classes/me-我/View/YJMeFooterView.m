//
//  YJMeFooterView.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/5.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJMeFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YJSquare.h"
#import "YJSquareButton.h"
#import "YJWebViewController.h"
//按钮的图片要导入按钮的webcache
#import "UIButton+WebCache.h"
@implementation YJMeFooterView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
   
        self.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        //参数
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"a"]=@"square";
        params[@"c"]=@"topic";
        //发送请求
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            [responseObject writeToFile:@"/Users/Bao/Desktop/square.plist" atomically:YES];
            NSArray *squares=[YJSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}
-(void)createSquares:(NSArray *)squares{
    //一行做多四列
    int maxCols=5;
    //宽度和高度
    CGFloat buttonW=[[UIScreen mainScreen]bounds].size.width/maxCols;
    CGFloat buttonH=buttonW;
    
    for(int i=0;i<squares.count;i++){
        YJSquare *square=squares[i];
        YJSquareButton *btn=[YJSquareButton buttonWithType:UIButtonTypeCustom];
        btn.square=squares[i];
//        [btn setTitle:square.name forState:UIControlStateNormal];
//        [btn sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        //添加点击方法
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        int col=i%5;
        int row=i/5;
        btn.x=col*buttonW;
        btn.y=row*buttonH;
        btn.width=buttonW;
        btn.height=buttonH;
        //计算footer的高度
        self.height=CGRectGetMaxY(btn.frame);
    }
    //重绘
    [self setNeedsDisplay];
}
//设置背景图片
//-(void)drawRect:(CGRect)rect{
////    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}
-(void)btnClick:(YJSquareButton *)button{
    YJLog(@"----------%@--------%@",button.square.name,button.square.url);
    if(![button.square.url hasPrefix:@"http"]){
        return;
    }
    YJWebViewController *web=[[YJWebViewController alloc]init];
    web.url=button.square.url;
    web.title=button.square.name;
    //取出当前的导航控制器
    UITabBarController *tabBarVc=(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav=(UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}
@end
