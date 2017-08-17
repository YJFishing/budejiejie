//
//  YJSettingViewController.m
//  百思不得姐
//
//  Created by 包宇津 on 16/5/20.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJSettingViewController.h"
#import <SDImageCache.h>
@interface YJSettingViewController ()

@end

@implementation YJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title=@"设置 ";
    self.tableView.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    
    
   
}
-(void)getSize{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *caches=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *cachePath=[caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSDirectoryEnumerator *fileEnumerator=[[NSFileManager defaultManager]enumeratorAtPath:cachePath];
    NSUInteger total=0;
    
    for(NSString *fileName in fileEnumerator){
        BOOL isDir=NO;
        YJLog(@"%@",fileName );
        NSString *filePath=[cachePath stringByAppendingPathComponent:fileName];
        [manager fileExistsAtPath:filePath isDirectory:&isDir];
        if(isDir) continue;
        NSUInteger size=[[manager attributesOfItemAtPath:filePath error:nil][NSFileSize]integerValue];
        total+=size;
    }
    YJLog(@"%zd",total);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Configure the cell...
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewStyleGrouped reuseIdentifier:@"cell"];
    }
    //清楚缓存
    CGFloat size=[SDImageCache sharedImageCache].getSize/1000.0/1000.0;
    cell.textLabel.text=[NSString stringWithFormat:@"清除缓存(已使用%.1fMB)",size];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache]clearDisk];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
