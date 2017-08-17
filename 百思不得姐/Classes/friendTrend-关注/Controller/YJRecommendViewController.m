//
//  YJRecommendViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/24.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "YJRecommendCategoryCell.h"
#import "MJExtension.h"
#import "YJRecommendCategory.h"
#import "YJRemommendUserCell.h"
#import "YJRecommendUser.h"
#import "MJRefresh.h"

@interface YJRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
//左边的类别数据
@property (nonatomic,strong) NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右边的用户数据
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
//请求参数
@property (nonatomic,strong) NSMutableDictionary *params;
//AFN请求管理者
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation YJRecommendViewController
-(AFHTTPSessionManager *)manager{
    if(_manager==nil){
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加刷新控件
    [self setupRefresh];
    self.categoryTableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    //左侧表格Cell注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
    //右侧表格Cell注册
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJRemommendUserCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.categoryTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset=self.categoryTableView.contentInset;
    self.title=@"推荐关注";
    //设置背景色
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    //显示指示器
    [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    //发送请求
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"category";
    params[@"c"]=@"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YJLog(@"%@",responseObject);
        //服务器返回JSON数据
        self.categories=[YJRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"] ];
        //与隐藏指示器
        [SVProgressHUD dismiss];
        
        //设置cell高度
        self.userTableView.rowHeight=60;
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath  indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //进入下拉刷新
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        
    }];
}

-(void)setupRefresh{
    self.userTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden=YES;
}
#pragma mark -加载用户数据
-(void)loadMoreUsers{
    YJLog(@"%s",__func__);
    YJRecommendCategory *info=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(info.id);
    params[@"page"]=@(++info.currentPage);
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.params!=params){
            return;
        }
        YJLog(@"%@",responseObject);
        NSArray *users=[YJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [info.users addObjectsFromArray:users];
        [self.userTableView reloadData];
        //让底部控件结束刷新
        if(info.total==info.users.count){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YJLog(@"err...");
    }];
    
}
-(void)loadNewUsers{
    YJLog(@"%s",__func__);
    YJRecommendCategory *info=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    info.currentPage=1;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(info.id);
    params[@"page"]=@(info.currentPage);
     self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                YJLog(@"%@",responseObject);
        NSArray *users=[YJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除所有旧数据
        [info.users removeAllObjects];
        //添加到当前类别对应的用户数组中
        [info.users addObjectsFromArray:users];
        info.total=[responseObject[@"total"] integerValue];
        if(self.params!=params)
            return;
        if(info.users.count==info.total){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        //让底部控件结束刷新
        if(info.total==info.users.count){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YJLog(@"err...");
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
				
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -<UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.categoryTableView){
        return self.categories.count;
    }else{
        YJRecommendCategory *info=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        //每次刷新右边数据时，都控制footer显示或隐藏
        self.userTableView.mj_footer.hidden=(info.users.count==0);
        if(info.total==info.users.count){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        return info.users.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.categoryTableView){//左边类别表格
        YJRecommendCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"category"];
        cell.category=self.categories[indexPath.row];
        return cell;
    }else {//右边用户表格
        YJRemommendUserCell *cell=[tableView dequeueReusableCellWithIdentifier:@"user"];
        YJRecommendCategory *info=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user=info.users[indexPath.row];
        return cell;
    }
}

#pragma mark -<UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //结束刷新
    [self.userTableView.mj_footer endRefreshing];
    [self.userTableView.mj_header endRefreshing];
    YJRecommendCategory *info=self.categories[indexPath.row];
    YJLog(@"%@",info.name);
    
    if(info.users.count>0){//已有用户数据
        YJLog(@"复用数据。。。。。。");
        [self.userTableView reloadData];
    }else{//没有用户数据，重新加载
        //解决由于网速慢 切换条目时右侧内容不改变
        [self.userTableView reloadData];
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    }
}
//控制器的销毁
-(void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
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
