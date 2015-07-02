//
//  TabViewController.m
//  BigDiaoMan
//
//  Created by xjkj on 14-8-22.
//  Copyright (c) 2014年 xjkj. All rights reserved.
//

#import "TabViewController.h"
#import "ListCell.h"
@interface TabViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) CNPGridMenu *gridMenu;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TabViewController

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

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 12;
}
#pragma -mark-heightForRowAtIndexPath
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *str=@"ListCell";
    ListCell  *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil];
        cell = (ListCell *)[nibArray objectAtIndex:0];
        cell.selectedBackgroundView.backgroundColor=kSystemSelectBackgroundColor;
        // [cell animationForIndexPath:indexPath];
        
    }
    
    //[cell animationDidStart:<#(CAAnimation *)#>];
    //[cell animationDidStop:<#(CAAnimation *)#> finished:YES];
    
    
    return cell;
    
    
    
}
#pragma -mark-点击触发tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   


}





@end
