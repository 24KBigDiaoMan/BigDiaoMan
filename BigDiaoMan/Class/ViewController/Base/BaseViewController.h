//
//  BaseViewController.h
//  ShengLoveParadise
//
//  Created by xjkj on 14-3-27.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController

@property(strong,nonatomic)NSMutableArray *postArry;//存储当前页面请求数组
-(void)bulidTitleView:(NSString*)title;
@property (weak, nonatomic)  UIButton *leftButton;
@property (weak, nonatomic)  UIButton *rightButton;
@property(assign,nonatomic)BOOL isCurrentPage;
@property (strong, nonatomic)UIActivityIndicatorView *activity;

-(void)touchRightBnt:(UIButton *)sender;
-(void)touchLeftBnt:(UIButton *)sender;
-(void)touchCenterView;

@end
