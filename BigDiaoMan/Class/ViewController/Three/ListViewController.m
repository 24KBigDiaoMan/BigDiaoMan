//
//  ListViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-22.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "ListViewController.h"
#import "ListCell.h"
#import "ReleaseListViewController.h"
#import "MapViewController.h"
@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchRightBnt:(UIButton *)sender{
    
    [super touchRightBnt:sender];
    ReleaseListViewController *release=[[ReleaseListViewController alloc]initWithNibName:@"ReleaseListViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:release];
    release.navigationController.navigationBarHidden=YES;

    [self presentViewController:nav animated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"列表";
    //右边Creepin‘Up On You Darren Hayes
    self.leftButton.hidden=YES;
    [self.rightButton setTitleColor:RGB(122, 12, 111, 1) forState:UIControlStateNormal];
    
    [self.rightButton setTitle:@"右边" forState:UIControlStateNormal];
    self.tableView.backgroundView=self.bgImageView;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 12;
}
#pragma -mark-heightForRowAtIndexPath
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString *str=@"ListCell";
    ListCell  *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil];
        cell = (ListCell *)[nibArray objectAtIndex:0];
        //cell.selectedBackgroundView.backgroundColor=kSystemSelectBackgroundColor;
        // [cell animationForIndexPath:indexPath];
        
    }
    
    //[cell animationDidStart:<#(CAAnimation *)#>];
    //[cell animationDidStop:<#(CAAnimation *)#> finished:YES];
    
    
    return cell;
    
    
 
}
#pragma -mark-点击触发tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MapViewController *map=[[MapViewController alloc]init];
    map.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:map animated:YES];
}

@end
