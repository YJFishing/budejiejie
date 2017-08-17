//
//  YJRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 包宇津 on 16/3/24.
//  Copyright © 2016年 BYJ_2015. All rights reserved.
//

#import "YJRecommendCategoryCell.h"
#import "YJRecommendCategory.h"
@interface YJRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation YJRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.selectedIndicator.backgroundColor=[UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1.0];
//    self.textLabel.textColor=[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
//    self.textLabel.highlightedTextColor=[UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1.0];
}
//当cell的selection属性为none时，cell被选中时，内部的子控件就不会进入高亮状态
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectedIndicator.hidden=!selected;
    self.textLabel.textColor=selected?[UIColor colorWithRed:219/255.0 green:21/255.0 blue:26/255.0 alpha:1.0]:[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
}
-(void)setCategory:(YJRecommendCategory *)category{
    _category=category;
    self.textLabel.text=category.name;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //让textlabel高度变小一点，不要挡住自己添加的UIView分割线
    self.textLabel.y=1;
    self.textLabel.height=self.contentView.height-2;
}
@end
