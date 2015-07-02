//
//  RootTabBarViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-11.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "RootTabBarViewController.h"

#import "MainPageViewController.h"

#import "TabViewController.h"
#import "ListViewController.h"
#import "HomeViewController.h"//主页
@interface RootTabBarViewController (){
    NSArray *tabSelected;
    NSArray *tabUnselected;
}
@property(strong, nonatomic)UIImageView *tabBarBG;//地下背景
@end

@implementation RootTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //tab配置
    [self makeTabBarSetUp];
    //控制器初始化
    [self makeTabBarItem];
  
 
}
#pragma -mark- -----------------TabBar设置-----------------
#pragma -mark TabBar配置
-(void)makeTabBarSetUp{
    //tabBar字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(48 , 48 , 48, 1),
                                                        NSFontAttributeName:SystemFont(11)}
                                             forState:UIControlStateNormal];
    
    //tabBar字体选中的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(20 , 20 , 20, 1),
                                                        NSFontAttributeName:SystemFont(11)}
                                             forState:UIControlStateSelected];
    
    //图片选中的颜色
   // [[UITabBar appearance] setTintColor:RGB(86, 160 , 40, 1)];
    
    //[[UITabBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    
    //图片选中的背景
    //[[UITabBar appearance] setSelectionIndicatorImage:[Methods stretchImageName:@"tab_bg.png"]];
    
    
    
    
    
    //背景颜色
    //[[UITabBar appearance] setBarTintColor:RGB(180, 180, 180, 1)];
    
    //背景颜色－用图片
   // [[UITabBar appearance] setBackgroundImage: [self getBgImage] ];
    
    /*
    if (!IsIOS7) {
        UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar_bg.png"];
        [[UITabBar appearance] setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsZero]];
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    }
     */

}
#pragma -mark TabBar控制器初始化
-(void)makeTabBarItem{
    MainPageViewController*main=[[MainPageViewController alloc]initWithNibName:@"MainPageViewController" bundle:nil];
    UINavigationController *mainNav=[self makeTabBarVC:main
                                           tabBarTitle:@"首页"
                                           tabBarImage:@"tab_recent_nor.png"
                                   tabBarSelectedImage:@"tab_recent_press.png"];
    
    
    TabViewController *table=[[TabViewController alloc]initWithNibName:@"TabViewController" bundle:nil];
    UINavigationController *tableNav=[self makeTabBarVC:table
                                            tabBarTitle:@"地图"
                                            tabBarImage:@"tab_me_nor.png"
                                    tabBarSelectedImage:@"tab_me_press.png"];
    
    
    ListViewController*list=[[ListViewController alloc]initWithNibName:@"ListViewController" bundle:nil];
    UINavigationController *listNav=[self makeTabBarVC:list
                                           tabBarTitle:@"发现"
                                           tabBarImage:@"tab_qworld_nor.png"
                                   tabBarSelectedImage:@"tab_qworld_press.png"];
    
    
    HomeViewController*home=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *homeNav=[self makeTabBarVC:home
                                           tabBarTitle:@"我的"
                                           tabBarImage:@"tab_buddy_nor.png"
                                   tabBarSelectedImage:@"tab_buddy_press.png"];
    
    
    [self setViewControllers:@[homeNav] animated:NO];
    

   
}
#pragma -mark- -----------------方法-----------------
#pragma -mark TabBar快速创建
-(UINavigationController*)makeTabBarVC:(UIViewController*)vc
                           tabBarTitle:(NSString*)title
                           tabBarImage:(NSString*)image
                   tabBarSelectedImage:(NSString*)selectedImage{
    
    UINavigationController *vcNav=[[UINavigationController alloc]initWithRootViewController:vc];
    UITabBarItem *barItem = [[UITabBarItem alloc]initWithTitle:title
                                                         image:SystemOriginalImage(image)
                                                 selectedImage:SystemOriginalImage(selectedImage)];
    
    vc.tabBarItem=barItem;
    //导航透明状态
    //vc.navigationController.navigationBar.translucent = NO;
    //是否隐藏导航
    //vc.navigationController.navigationBarHidden=YES;
    //系统自带返回
    vc.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    return vcNav;
}
#pragma -mark TabBar背景适配
-(UIImage*)getBgImage{
    UIImage *image;
    
    if (IsIPhone5s||IsIPhone4_4s) {
        image=SystemQuickImage(@"tab_bg_320.png");
    }else if (IsIPhone6) {
        image=SystemQuickImage(@"tab_bg_750.png");
    }else if (IsIPhone6Plus) {
        image=SystemQuickImage(@"tab_bg_828.png");
    }
    
    return image;
}
#pragma -mark- -----------------协议-----------------
#pragma -mark TabBar再次点击
- (BOOL)tabBarController:(UITabBarController *)tbc shouldSelectViewController:(UIViewController *)vc {
    UIViewController *tbSelectedController = tbc.selectedViewController;
    
    if ([tbSelectedController isEqual:vc]) {
        //在这里可以捕捉到这个方法
        //CLog(@"%@",[tbSelectedController class]);
        return NO;
    }
  
    return YES;
}

#pragma -mark- -----------------自定义TabBar-----------------
#pragma -mark 自定义TabBar快速创建
-(void)makeTabBarCustom
{
    self.tabBar.hidden=YES;
    
    tabUnselected=@[@"tab_recent_press.png",
                    @"tab_recent_press.png",
                    @"tab_recent_press.png",
                    @"tab_recent_press.png"];
    tabSelected=@[@"tab_recent_nor.png",
                  @"tab_recent_nor.png",
                  @"tab_recent_nor.png",
                  @"tab_recent_nor.png"];
    //tapbar 背景
    
    self.tabBarBG=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50,ScreenWidth, 49)];
    self.tabBarBG.userInteractionEnabled=YES;
    self.tabBarBG.image=[Methods stretchImageName:@"背景拉伸图片"];
    [self.view addSubview:self.tabBarBG];
    
    //------------------------------  加载按钮事件------------------------------
    
    for (int i=1; i<tabUnselected.count+1; i++) {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake((i-1)*(ScreenWidth/tabUnselected.count), 0, ScreenWidth/tabUnselected.count, 50);
        button.adjustsImageWhenHighlighted=NO;
        if (i==1)
        {
            [button setImage:[UIImage imageNamed:[tabSelected objectAtIndex:i-1]]
                    forState:UIControlStateNormal];
        }else
        {
            [button setImage:[UIImage imageNamed:[tabUnselected objectAtIndex:i-1]] forState:UIControlStateNormal];
        }
        
        button.tag=i;
        [button addTarget:self action:@selector(buttonActionGo:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarBG addSubview:button];
        
        
        
    }
    
    
    
    
}
static NSInteger ButtonForH=1;
#pragma -mark  点击自定义button切换页面
-(void)buttonActionGo:(UIButton*)button
{
    if (ButtonForH==button.tag)
    {
        CLog(@"重复点击");
        
    }else
    {
        UIButton *lastButton=(UIButton*)[self.tabBarBG viewWithTag:ButtonForH];
        
        [lastButton setImage:[UIImage imageNamed:[tabUnselected objectAtIndex:lastButton.tag-1]]
                    forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[tabSelected objectAtIndex:button.tag-1]]
                forState:UIControlStateNormal];
        ButtonForH=button.tag;
        
    }
    self.selectedIndex=button.tag-1;
    
    
}


@end
