//
//  YJCommentViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/18.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJCommentViewController.h"
#import "YJTopicCell.h"
#import "YJTopic.h"
#import <MJRefresh.h>
#import "AFNetworking.h"
#import "YJComment.h"
#import "MJExtension.h"
#import "YJCommentCell.h"

static NSString *YJCommentID=@"comment";
@interface YJCommentViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**最新评论*/
@property (nonatomic,strong) NSMutableArray *latestComments;
/** 最热评论*/
@property (nonatomic,strong) NSArray *hotComments;
/**保存帖子的top_cmt */
@property (nonatomic,strong) NSArray *saved_top_cmt;
/**保存当前的页码*/
@property (nonatomic,assign) NSInteger page;
/**管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation YJCommentViewController
-(AFHTTPSessionManager *)manager{
    if(_manager==nil){
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpBasic];
    [self setUpHeader];
    [self setUpRefresh];
}
-(NSMutableArray *)latestComments{
    if(_latestComments==nil){
        _latestComments=[[NSMutableArray alloc]init];
    }
    return _latestComments;
}
-(void)setUpRefresh{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden=YES;
}
-(void)loadMoreComments{
    //结束之前发出的所有网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //页码
    NSInteger page=self.page+1;
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]= @"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topic.ID;
    params[@"page"]=@(page);
    YJComment *cmt=[self.latestComments lastObject];
    params[@"lastcid"]=cmt.ID;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最新评论
        NSArray *newComments=[YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page=page;
        //控制footer的状态
        NSInteger total=[responseObject[@"total"] integerValue];
        if(_latestComments.count>=total){//全部加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)loadNewComments{
    //结束网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    YJLog(@"%s",__func__);
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]= @"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topic.ID;
    params[@"hot"]=@"1";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        YJLog(@"%@",responseObject);
        //        [responseObject writeToFile:@"/Users/Bao/Desktop/comment.plist" atomically:YES];
        //最热评论
        self.hotComments=[YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments=[YJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //刷新成功 page==1
        self.page=1;
        //控制footer的状态
        NSInteger total=[responseObject[@"total"] integerValue];
        if(_latestComments.count>=total){//全部加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)setUpHeader{
    //清空top_cmt
    if(self.topic.top_cmt.count){
        self.saved_top_cmt=self.topic.top_cmt;
        self.topic.top_cmt=nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    UIView *header=[[UIView alloc]init];
    //添加cell
    YJTopicCell *cell=[YJTopicCell cell];
    cell.topic=self.topic;
    //    cell.size=CGSizeMake([[UIScreen mainScreen]bounds].size.width,self.topic.cellHeight);
    cell.frame=CGRectMake(0, -32, [[UIScreen mainScreen]bounds].size.width, self.topic.cellHeight);
    [header addSubview:cell];
    header.height=self.topic.cellHeight+20;
    self.tableView.tableHeaderView=header;
}
-(void)setUpBasic{
    self.title=@"评论";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJCommentCell class]) bundle:nil] forCellReuseIdentifier:YJCommentID];
    
    //cell的高度设置 ios8 之后才有
    self.tableView.estimatedRowHeight=44;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    //去掉分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)keyBoardWillChangeFrame:(NSNotification *)note{
    //键盘显示/隐藏完毕的frame
    CGRect frame=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant=[[UIScreen mainScreen]bounds].size.height-frame.origin.y;
    //动画时间
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //恢复top_cmt
    if(self.saved_top_cmt.count){
        self.topic.top_cmt=self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}
-(NSArray *)commentsInSection:(NSInteger)section{
    if(section==0)
        return self.hotComments.count?self.hotComments:self.latestComments;
    return self.latestComments;
}
-(YJComment *)commentInIndexPath:(NSIndexPath *)indexpath{
    return [self commentsInSection:indexpath.section][indexpath.row];
}
#pragma mark -数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount=self.hotComments.count;
    NSInteger latestCount=self.latestComments.count;
    if(hotCount) return 2;
    if(latestCount) return 1;
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount=self.hotComments.count;
    NSInteger latestCount=self.latestComments.count;
    //隐藏尾部控件
    self.tableView.mj_footer.hidden=(latestCount==0);
    if(section==0){
        return hotCount?hotCount:latestCount;
    }else if(section==1){
        return latestCount;
    }else{
        return 0;
    }
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSInteger hotCount=self.hotComments.count;
//    NSInteger latestCount=self.latestComments.count;
//    if(section==0)
//        return hotCount?@"最热评论":@"最新评论";
//    return @"最新评论";
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header=[[UIView alloc]init];
//    UILabel *label=[[UILabel alloc]init];
//    label.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
//    label.width=200;
//    label.x=10;
//    label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
//    [header addSubview:label];
//    NSInteger hotCount=self.hotComments.count;
//    NSInteger latestCount=self.latestComments.count;
//    if(section==0){
//        label.text=hotCount ? @"最热评论":@"最新评论";
//    }else{
//        label.text=@"最新评论";
//    }
//    return header;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *ID=@"header";
    //先从缓存池中找header
    UITableViewHeaderFooterView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    UILabel *label=nil;
    if(header==nil){//缓存池中没有，自己创建
        header=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
        //创建Label
        label=[[UILabel alloc]init];
        label.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
        label.width=200;
        label.x=10;
        label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        label.tag=99;
        [header addSubview:label];
    }else{//从缓存池中取出来的
        label=(UILabel *)[header viewWithTag:99];
    }
    //label的数据
    NSInteger hotCount=self.hotComments.count;
    //        NSInteger latestCount=self.latestComments.count;
    if(section==0){
        label.text=hotCount ? @"最热评论":@"最新评论";
    }else{
        label.text=@"最新评论";
    }
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:YJCommentID];
    //    if(cell==nil){
    //        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YJCommentID];
    //    }
    //    YJComment *comment=[self commentInIndexPath:indexPath];
    //    cell.textLabel.text=comment.content;
    cell.comment=[self commentInIndexPath:indexPath];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJLog(@"%s",__func__);
    //被点击的cell
    YJCommentCell *cell=(YJCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    //显示menuController
    UIMenuController *menu=[UIMenuController sharedMenuController];
    if(menu.isMenuVisible){
        [menu setMenuVisible:NO animated:YES];
    }else{
        UIMenuItem *ding=[[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *reply=[[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(reply:)];
        UIMenuItem *report=[[UIMenuItem alloc]initWithTitle:@"报告" action:@selector(report:)];
        menu.menuItems=@[ding,reply,report];
        CGRect rect=CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        
    }
}
-(void)ding:(UIMenuController *)menu{
    NSIndexPath *index=[self.tableView indexPathForSelectedRow];
    YJLog(@"%s %@ %zd",__func__,menu,index.row);
}
-(void)reply:(UIMenuController *)menu{
    YJLog(@"%s %@",__func__,menu);
}
-(void)report:(UIMenuController *)menu{
    YJLog(@"%s %@",__func__,menu);
}
@end
