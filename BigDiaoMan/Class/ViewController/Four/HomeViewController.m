//
//  HomeViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-14.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "HomeViewController.h"
#import "SetUpCell.h"
@interface HomeViewController (){
      NSMutableArray *titileMArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchRightBnt:(UIButton *)sender{
    
    CLog(@"444");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"个人中心";
    //右边
    self.leftButton.hidden=YES;
    [self.rightButton setTitleColor:RGB(122, 12, 111, 1) forState:UIControlStateNormal];
    
    [self.rightButton setTitle:@"设置" forState:UIControlStateNormal];
    
    titileMArray=[[NSMutableArray alloc]init];
    [titileMArray addObjectsFromArray:@[@"1"]];
    
    self.userImageView.layer.masksToBounds=YES;
    self.userImageView.layer.cornerRadius=50;
    self.userImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth=2;
    self.bgImageView.frame=JJ_RectMake(0, -200, ScreenWidth, 500);
    
}


#pragma -mark ------------------------拉动UIScrollView------------------------
- (void)scrollViewDidScroll:(UIScrollView *)xscrollView
{
   
    if (xscrollView.contentOffset.y<0)
    {
        //拉伸
        self.bgImageView.frame=JJ_RectMake(0,(-200-(xscrollView.contentOffset.y)/2), ScreenWidth, 500);
    }else
    {
        //跟列表混动
        self.bgImageView.frame=JJ_RectMake(0,(-200-(xscrollView.contentOffset.y)), ScreenWidth, 500);
    }
    
  
    
}
#pragma mark - ------------------------Table view 基本设置------------------------
#pragma -mark-numberOfSectionsInTableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

#pragma -mark-numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titileMArray.count;
}
#pragma -mark-heightForRowAtIndexPath
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma -mark-UITableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"SetUpCell";
    SetUpCell  *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SetUpCell" owner:self options:nil];
        cell = (SetUpCell *)[nibArray objectAtIndex:0];
        cell.selectedBackgroundView.backgroundColor=kSystemSelectBackgroundColor;
        // [cell animationForIndexPath:indexPath];
        
    }
    
    return cell;
}
#pragma -mark-点击触发tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
