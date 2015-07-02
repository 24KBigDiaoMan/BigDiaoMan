//
//  SphereMenu.h
//  SphereMenu
//
//  Created by Tu You on 14-8-24.
//  Copyright (c) 2014年 TU YOU. All rights reserved.
//
/*
 
 UIImage *startImage = [UIImage imageNamed:@"start"];
 UIImage *image1 = [UIImage imageNamed:@"icon-twitter"];
 UIImage *image2 = [UIImage imageNamed:@"icon-email"];
 UIImage *image3 = [UIImage imageNamed:@"icon-facebook"];
 NSArray *images = @[image1, image2, image3];
 SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake(160, 320)
 startImage:startImage
 submenuImages:images];
 sphereMenu.sphereDidSelected=^(int index){
 NSLog(@"%d",index);
 };
 
 [self.view addSubview:sphereMenu];

 
 
 
 */
#import <UIKit/UIKit.h>

@protocol SphereMenuDelegate <NSObject>

- (void)sphereDidSelected:(int)index;

@end

@interface SphereMenu : UIView

@property (weak, nonatomic) id<SphereMenuDelegate> delegate;
@property (copy, nonatomic)void(^sphereDidSelected)(int index);
- (instancetype)initWithStartPoint:(CGPoint)startPoint
                        startImage:(UIImage *)startImage
                     submenuImages:(NSArray *)images;

@end
