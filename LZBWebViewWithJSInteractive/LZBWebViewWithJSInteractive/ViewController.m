//
//  ViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBDataModel.h"
#import "LZBJStoOCFromURLMethodVC.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<LZBDataModel *> *datas;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择类型";
    [self.view addSubview:self.tableView];
    self.datas = @[
    [[LZBDataModel alloc]initWithVC:[[LZBJStoOCFromURLMethodVC alloc]init] withTitle:@"JS调用OC-URL方法"],
    [[LZBDataModel alloc]initWithVC:nil withTitle:@"JS调用OC第二方法"],
    [[LZBDataModel alloc]initWithVC:nil withTitle:@"OC调用JS第一方法"],
    [[LZBDataModel alloc]initWithVC:nil withTitle:@"OC调用JS第二方法"],];
    
    
   
}
#pragma mark - tableView的dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *UITableViewCellID = @"UITableViewCellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    if(cell == nil)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.datas[indexPath.row].title;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:self.datas[indexPath.row].vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
  if(_tableView == nil)
  {
      _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
      _tableView.delegate = self;
      _tableView.dataSource = self;
      _tableView.frame = self.view.bounds;
  }
    return _tableView;
}





@end
