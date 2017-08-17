//
//  YJTopicViewController.h
//  百思不得姐
//
//  Created by 包宇津 on 16/4/7.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    YJTopicTypeAll=1,
    YJTopicTypePicture=10,
    YJTopicTypeWord=29,
    YJTopicTypeVoice=31,
    YJTopicTypeVideo=41
}YJTopicType;

@interface YJTopicViewController : UITableViewController
-(NSString *)type;
@end
