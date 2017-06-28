//
//  DetailViewController.m
//  空白数据显示界面
//
//  Created by 郑文青 on 2017/6/28.
//  Copyright © 2017年 zhengwenqing’s mac. All rights reserved.
//

#import "DetailViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface DetailViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation DetailViewController
//模拟数据
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//为该属性设置 setter 方法，重新加载空数据集视图
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self.tableView reloadEmptyDataSet];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = @"👉";
    UIBarButtonItem *trashItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clickTrashBarItem)];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickRefreshBarItem)];
    self.navigationItem.rightBarButtonItems = @[trashItem,refreshItem];
    //遵循代理和数据源
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    

    self.tableView.tableFooterView = [UIView new];
}

//删除
-(void)clickTrashBarItem
{
    [_dataArray removeAllObjects];
    [self.tableView reloadData];
}
//刷新
-(void)clickRefreshBarItem
{
    [_dataArray removeAllObjects];
    for (int  i = 0; i <= 10; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"模拟数据--%d",i]];
    }
    [self.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark DZNEmptyDataSetSource,
//需要实现什么样的样式,就实现下面对应的数据源方法即可

//设置图片的 tintColor
//- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIColor yellowColor];
//}

//设置空白页面的背景色
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
//    UIColor *appleGreenColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
//    return appleGreenColor;
//}

//空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    
    if (self.isLoading) {
        // 圆形加载图片
        return  [UIImage imageNamed:@"loading1"] ;
    }else {
        // 默认静态图片
        return _row != 6 ? [UIImage imageNamed:@"placeholder_remote"] : nil;
    }
    
}

// 图像视图动画:
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = nil;
    
    if (_row == 2){//缩放
        
        animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.duration = 1.55;
        animation.cumulative = NO;
        animation.repeatCount = MAXFLOAT;
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 45, 45)];
    }else{//旋转
        animation  = [CABasicAnimation animationWithKeyPath: @"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
        
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        
        
        return animation;
    }
    return  animation ;
}

//标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有数据~";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    NSAttributedString *attString = nil;
    
    if (_row == 3 || _row == 4) {
       attString = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    }
    
    return attString;
}
//详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"我是详情标题,这里提示用户造成没有数据的一些情况,如没有网络或者没有数据等";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
     NSAttributedString *attString = nil;
    
    if (_row == 4 || _row == 5) {
        attString = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    return attString;
}
//显示按钮
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *buttonTitle = @"点我刷新";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f],
                                 NSForegroundColorAttributeName:[UIColor orangeColor],
                                 };
    
    NSAttributedString *attString = nil;
    
    if (_row == 5 ||_row == 6) {
        attString = [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
    }
    return attString;
}

//自定义按钮的样式背景
- (nullable UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return (_row == 5 ||_row == 6) ? [UIImage imageNamed:@"background"] : nil;
}

//也可以把按钮设置成图片
//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    return   [UIImage imageNamed:@"background"];
//}

//如果您需要更复杂的布局，也可以返回自定义视图
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    
    return (_row == 7) ? activityView : nil;
}


#pragma mark  DZNEmptyDataSetDelegate
//空白view上的图片 的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"点击空白view上的图片");
    
    // 空白页面被点击时开启动画，reloadEmptyDataSet
    self.loading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 关闭动画，reloadEmptyDataSet
        self.loading = NO;
        [self clickRefreshBarItem];
    });
   
}
//空白view上的button 的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"点击空白view上的button");
    self.loading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 关闭动画，reloadEmptyDataSet
        self.loading = NO;
        [self clickRefreshBarItem];
    });
}

// 向代理请求图像视图动画权限。 默认值为NO。
// 确保从 imageAnimationForEmptyDataSet 返回有效的CAAnimation对象：
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return  self.isLoading ;
}

@end
