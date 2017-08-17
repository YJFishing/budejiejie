//
//  YJRecommendTagsViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/26.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "MJExtension.h"
#import "YJRecommendTag.h"
#import "YJRecommendTagCell.h"
@interface YJRecommendTagsViewController ()
//标签数据
@property (nonatomic,strong) NSArray *tags;
@end

@implementation YJRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    [self setupTableView];
    [self loadTags];
   }
-(void)setupTableView{
      //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    self.title=@"推荐标签";
    self.tableView.rowHeight=70;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
}
-(void)loadTags{
    //发送请求
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    //请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"tag_recommend";
    params[@"action"]=@"sub";
    params[@"c"]=@"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YJLog(@"%@",responseObject);
        self.tags=[YJRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    YJRecommendTagCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tag"];
    cell.recommendTag=self.tags[indexPath.row];
    return cell;
}



@end
