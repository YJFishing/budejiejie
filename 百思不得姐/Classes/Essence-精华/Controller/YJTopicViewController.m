//
//  YJTopicViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/4/1.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJTopicViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YJTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YJTopicCell.h"
#import "YJConst.h"
#import "YJCommentViewController.h"
#import "YJNewViewController.h"
@interface YJTopicViewController ()
//帖子数据
@property (nonatomic,strong) NSMutableArray *topics;
//当前页码
@property (nonatomic,assign) NSInteger currentPage;
//当加载下一页数据时需要这个参数
@property (nonatomic,copy) NSString *maxtime;
//请求参数
@property (nonatomic,strong) NSDictionary *params;
/**上次选中的索引或者控制器*/
@property (nonatomic,assign) NSInteger lastSelectedIndex;
@end

@implementation YJTopicViewController
-(NSString *)type{
    return nil;
}
-(NSMutableArray *)topics{
    if(_topics==nil){
        _topics=[NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //添加刷新控件
    [self setupRefresh];
    //初始化表格
    [self setupTableView];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha=YES;
    //底部添加刷新
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
-(void)setupTableView{
    //设置内边距
    CGFloat bottom=self.tabBarController.tabBar.height;
    CGFloat top=YJTitleViewY+YJTitlesViewH;
    self.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets=self.tableView.contentInset;
    self.tableView.backgroundColor=[UIColor clearColor];
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJTopicCell class]) bundle:nil] forCellReuseIdentifier:@"topic"];
    
    //监听tabBar的点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarClick) name:YJTabBarDidSelectNotification object:nil];
}
-(void)tabBarClick{
    //如果选中的不是当前的导航控制器，直接返回
//    if(self.tabBarController.selectedViewController!=self.navigationController){
//        return;
//    }
    //如果不是连续选中两次，返回
    if(self.lastSelectedIndex==self.tabBarController.selectedIndex&&self.tabBarController.selectedViewController==self.navigationController&&self.view.isShowingOnKeyWindow){
        YJLog(@"%s",__func__);

        [self.tableView.mj_header beginRefreshing];
    }else{
        self.lastSelectedIndex=self.tabBarController.selectedIndex;
    }
}
-(void)setupRefresh{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
}
-(NSString *)a{
    return [self.parentViewController isKindOfClass:[YJNewViewController class]]?@"newlist":@"list";
}
//加载更多数据
-(void)loadMoreTopics{ 
    [self.tableView.mj_footer endRefreshing];
    self.currentPage++;
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"c"]=@"data";
    params[@"a"]=[self a];
    params[@"type"]=self.type;
    params[@"page"]=@(self.currentPage);
    params[@"maxtime"]=self.maxtime;
    if(self.params==params)return;
    self.params=params;
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YJLog(@"%@",responseObject);
        //字典转模型
        NSArray *topics=[YJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //        [responseObject writeToFile:@"/Users/Bao/Desktop/duanzi.plist" atomically:YES];
        //        self.topics=responseObject[@"list"];
        [self.topics addObjectsFromArray:topics];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //恢复页码
        self.currentPage--;
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}
//加载新的帖子数据
-(void)loadNewTopics{
    [self.tableView.mj_header endRefreshing];
    //参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"c"]=@"data";
    params[@"a"]=@"list";
    params[@"type"]=self.type;
    if(self.params==params)return;
    self.params=params;
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YJLog(@"%@",responseObject);
        //取出maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.topics=[YJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //        [responseObject writeToFile:@"/Users/Bao/Desktop/duanzi.plist" atomically:YES];
        //        self.topics=responseObject[@"list"];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.currentPage=0;
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    self.tableView.mj_footer.hidden=(self.topics.count==0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"topic";
    YJTopicCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    // Configure the cell...
    cell.topic=self.topics[indexPath.row];
    //    cell.textLabel.text=topics.name;
    //    cell.detailTextLabel.text=topics.text;
    //    [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出帖子模型
    YJTopic *topic=self.topics[indexPath.row];
    
    return topic.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJLog(@"%ld",(long)indexPath.row);
    YJCommentViewController *cmVC=[[YJCommentViewController alloc]init];
    cmVC.topic=self.topics[indexPath.row];
    [self.navigationController pushViewController:cmVC animated:YES];
}

@end
