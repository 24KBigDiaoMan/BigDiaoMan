//
//  MainPageViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-11.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "MainPageViewController.h"
#import "RootListCollectionViewCell.h"
#import "WaterFLayout.h"
#import "SetUpViewController.h"//设置
#import "TakePhotoViewController.h"//照相
#import "ReadViewController.h"//读书
@interface MainPageViewController (){
    NSArray *picArry;
    NSArray *titleArry;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MainPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(UIViewController*)viewController{
    
    for (UIView *nowView=[self.view superview]; nowView; nowView=nowView.superview) {
        
        UIResponder *nowResponder=[nowView nextResponder];
        if ([nowResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nowResponder;
        }
    }
    
    return nil;
}
-(void)touchRightBnt:(UIButton *)sender{
    
    [super touchRightBnt:sender];
    
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.leftButton.hidden=YES;
    self.navigationItem.title=@"你好";
    //右边
    [self.rightButton setImage:[UIImage imageNamed:@"navigationbar_setting_highlighted.png"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"navigationbar_setting.png"] forState:UIControlStateHighlighted];
    
    picArry=@[@"bg1.jpg",@"bg1.jpg",@"bg1.jpg",@"bg1.jpg",@"bg1.jpg",@"bg2.jpg",@"bg3.jpg",@"bg4.jpg",@"bg5.jpg",@"bg6.jpg"];
    

    
    
    //官方瀑布流
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //自定义瀑布流
    WaterFLayout* flowLayout = [[WaterFLayout alloc]init];
    flowLayout.columnCount=2;
    flowLayout.minimumColumnSpacing=5;//横边距
    flowLayout.minimumInteritemSpacing=10;//竖边距
    flowLayout.sectionInset= UIEdgeInsetsMake(10, 5,10, 5);
    
    self.collectionView.bounces = YES;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.collectionViewLayout=flowLayout;
    //-------------------注册UICollectionViewFlowLayout----------------------
    [self.collectionView registerClass:[RootListCollectionViewCell class] forCellWithReuseIdentifier:@"RootListCollectionViewCell"];
    
    
    
}
#pragma mark ------------------- collectionView基础设置------------------
#pragma mark 打开点击事件
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark 设置分区

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
#pragma mark 每个区内的元素个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return picArry.count;
}
#pragma mark 设置元素内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str=@"RootListCollectionViewCell";
    
    RootListCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
   
    cell.pic.image=SystemQuickImage([picArry objectAtIndex:indexPath.row]);
   // cell.lab.text=[titleArry objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

#pragma mark 设置元素大小比例
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(150, 150);
}
/*
-(CGSize)getSize:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
        return CGSizeMake(150,100);
        }
            break;
        case 1:
        {
            return CGSizeMake(150,120);
        }
            break;
        case 2:
        {
            return CGSizeMake(150,50);
        }
            break;
        case 3:
        {
            return CGSizeMake(150,70);
        }
            break;
        case 4:
        {
            return CGSizeMake(150,160);
        }
            break;
        case 5:
        {
            return CGSizeMake(150,190);
        }
            break;
        case 6:
        {
            return CGSizeMake(150,120);
        }
            break;
        case 7:
        {
            return CGSizeMake(150,50);
        }
            break;
        case 8:
        {
            return CGSizeMake(150,160);
        }
            break;
        case 9:
        {
            return CGSizeMake(150,90);
        }
            break;
        case 10:
        {
            return CGSizeMake(150,130);
        }
            break;
        default:
            return CGSizeMake(150,120);
            break;
    }
}
 */
#pragma mark ------------------- collectionView点击事件------------------
#pragma mark 点击元素触发事件

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            TakePhotoViewController *take=[[TakePhotoViewController alloc]initWithNibName:@"TakePhotoViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:take];
            take.navigationController.navigationBarHidden=YES;
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 1:{
            
            ReadViewController *read=[[ReadViewController alloc]initWithNibName:@"ReadViewController" bundle:nil];
            

            read.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:read animated:YES];
            
        }
         break;
        case 2:{
            
            
            NZAlertView *alertView=[[NZAlertView alloc]initWithStyle:NZAlertStyleSuccess
                                                      statusBarColor:nil
                                                               title:@"恭喜！"
                                                             message:@"保存成功！"];
            [alertView showWithCompletion:^{
           
            }];
        }
             break;
        case 3:{
            SetUpViewController *setUp=[[SetUpViewController alloc]initWithNibName:@"SetUpViewController" bundle:nil];
//            setUp.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:setUp animated:YES];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:setUp];
            setUp.navigationController.navigationBarHidden=YES;
            [self presentViewController:nav animated:YES completion:nil];
            
        }
            break;
            default:
            break;
    }
    
}


@end
