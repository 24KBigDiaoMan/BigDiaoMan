//
//  BaseViewController.m
//  ShengLoveParadise
//
//  Created by xjkj on 14-3-27.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "BaseViewController.h"
//#import "AMWaveTransition.h"
@interface BaseViewController ()<UINavigationControllerDelegate>
@property(strong ,nonatomic)UIView *coustomView;
@property(strong ,nonatomic)UILabel *titleLab;

@end

@implementation BaseViewController

#pragma -mark ------------------------通知栏控制------------------------


#pragma -mark ------------------------通知栏控制------------------------
#pragma -mark 页面即将载入
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isCurrentPage=YES;
}
#pragma -mark 页面即将消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isCurrentPage=NO;
}
#pragma -mark 页面载入
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=kSystemBgColor;
    self.leftButton.hidden=NO;
    if (IsIOS7||IsIOS8) {
    self.automaticallyAdjustsScrollViewInsets=YES;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
        }
    /*
    UIImage *iamge=[[UIImage imageNamed:@"每日推荐-标题栏下方间隔.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIImageView *headerView=[[UIImageView alloc]initWithImage:iamge];
    headerView.frame=CGRectMake(0, 0, ScreenWidth, 0);
    [self.view addSubview:headerView];
    [self.view bringSubviewToFront:headerView];
    
    */
    
}
#pragma -mark- -----------------导航UI设置-----------------
#pragma -mark 左边按钮
-(UIButton *)leftButton{
    
    if (!_leftButton) {
        //左边按钮
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"back_press.png"] forState:UIControlStateHighlighted];
        _leftButton.frame=CGRectMake(0, 0, 40, 44);
        //_leftButton.backgroundColor=[UIColor yellowColor];
        //_leftButton.hidden=YES;
        [_leftButton addTarget:self action:@selector(touchLeftBnt:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    }return _leftButton;
}


#pragma -mark 右边按钮初始化
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame=CGRectMake(0, 0, 60, 30);
        [_rightButton setTitleColor:RGB(255, 255, 255, 1) forState:UIControlStateNormal];
        [_rightButton setTitleColor:RGB(10 , 100 , 20, 1) forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(touchRightBnt:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    }return _rightButton;
}
#pragma -mark -------中间自定义View
#pragma -mark 构建中间自定义
-(void)bulidTitleView:(NSString*)title{
    
    self.titleLab.text=title;
    self.coustomView.hidden=NO;
}
#pragma -mark 中间自定义
-(UIView *)coustomView{
    if (!_coustomView) {
        _coustomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        _coustomView.backgroundColor=[UIColor clearColor];
        self.titleLab.center=CGPointMake(self.coustomView.center.x, self.coustomView.center.y+3);
        [_coustomView addSubview:self.titleLab];
        _coustomView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                           action:@selector(touchCenterView)];
        [_coustomView addGestureRecognizer:tap];
        self.navigationItem.titleView=_coustomView;
        
        
    }return _coustomView;
}
#pragma -mark 中间自定义UILabel
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        _titleLab.textAlignment=NSTextAlignmentCenter;
        //_titleLab.shadowColor=RGB_X(0x000000);
        _titleLab.backgroundColor=[UIColor clearColor];
        _titleLab.font=[UIFont fontWithName:@"FZZhengHeiS-DB-GB" size:19];
        //_titleLab.font=[UIFont systemFontOfSize:19];
        _titleLab.textColor=[UIColor blackColor];
        _titleLab.textAlignment=NSTextAlignmentCenter;
    }return _titleLab;
    
}

#pragma -mark- -----------------菊花设置-----------------
#pragma -mark 菊花初始化
-(UIActivityIndicatorView *)activity{
    if (!_activity) {
        _activity= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.center = CGPointMake(ScreenWidth/2, ScreenHeight/2-50);
        _activity.color = RGB(138, 195, 93, 1);
        [_activity setHidesWhenStopped:YES]; //当旋转结束时隐藏
        [self.view addSubview:_activity];
        
        // [_activity startAnimating]; // 开始旋转
        //[_activity stopAnimating]; // 结束旋转
        
    }return _activity;
}
#pragma -mark- -----------------事件传输-----------------
#pragma -mark 右边按钮事件
-(void)touchRightBnt:(UIButton *)sender{
    
}
#pragma -mark左边按钮事件
-(void)touchLeftBnt:(UIButton *)sender{
    //返回的时候 如果有请求队列 自动取消请求
    if (self.postArry.count) {
        for (int i=0; i<self.postArry.count; i++) {
            AFHTTPRequestOperation *post=(AFHTTPRequestOperation*) [self.postArry objectAtIndex:i];
            //返回页面 如果数据还在请求中  要取消
            if (post.isExecuting) {
                CLog(@"当前请求取消");
                [post cancel];
            }
        }
    }
    
    //默认当成返回 因为几乎都是推出 如果不是 别调用[super touchLeftBnt:sender]  子类自定义
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark 点击中间事件
-(void)touchCenterView{
    
}








@end
