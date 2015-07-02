//
//  RootListCollectionViewCell.m
//  BigDiaoMan
//
//  Created by xjkj on 14-7-24.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "RootListCollectionViewCell.h"
#import "UIImage+ImageEffects.h"
@implementation RootListCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"RootListCollectionViewCell" owner:self options: nil];
        
        if ([[arrayOfViews lastObject]isKindOfClass:[UICollectionViewCell class]]) {
             self = [arrayOfViews lastObject];
        }
        
        //毛玻璃1
        AMBlurView *amblurView=[[AMBlurView alloc]initWithFrame:self.bounds];
        amblurView.blurTintColor=[UIColor whiteColor];
        self.backgroundView=amblurView;
        
        //self.backgroundColor=[UIColor grayColor];
//        //毛玻璃2
//        UIImage *ambImage=[UIImage imageNamed:@"bg1.jpg"];
//        UIImageView *bgView=[[UIImageView alloc]init];
//        bgView.image=[ambImage applyLightEffect];
//        self.backgroundView=bgView;
//        
//        UIImage *selecteAmbImage=[UIImage imageNamed:@"bg3.jpg"];
//        UIImageView *selecteView=[[UIImageView alloc]init];
//        selecteView.image=[selecteAmbImage applyDarkEffect];
//         self.selectedBackgroundView=selecteView;
        
       //界面元素设定
        //self.layer.masksToBounds=YES;
        //self.layer.cornerRadius=5;
        //self.pic.layer.masksToBounds=YES;
       // self.pic.layer.cornerRadius=40;
        
        
    //真动画
//        self.pic.animationImages=@[SystemQuickImage(@"quan01_01.png"),
//                                   SystemQuickImage(@"quan01_02.png")];

        
//       self.pic.animationDuration=0.2;
//       [self.pic startAnimating];
        
       
        
        
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
