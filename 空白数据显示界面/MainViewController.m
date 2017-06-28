//
//  MainViewController.m
//  空白数据显示界面
//
//  Created by 郑文青 on 2017/6/28.
//  Copyright © 2017年 zhengwenqing’s mac. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
@interface MainViewController ()

@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation MainViewController
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"图片",@"图片+旋转动画",@"图片+缩放动画",@"图片+标题",@"图片+标题+副标题",@"图片+副标题+按钮",@"按钮",@"自定义"];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.row = indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
@end
