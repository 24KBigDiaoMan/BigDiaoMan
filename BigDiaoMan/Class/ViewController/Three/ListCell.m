//
//  ListCell.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-22.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib
{
    // Initialization code
    //背景拉伸
    UIImage *lineImage = [[UIImage imageNamed:@"editor_text.png"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(5,5, 5,5)];
    self.bgImageView.image=lineImage;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
