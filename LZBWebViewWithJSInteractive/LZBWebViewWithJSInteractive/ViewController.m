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
#import "LZBJStoOCFromJSContextViewController.h"
#import "LZBOCtoJSOneViewController.h"
#import "LZBOCtoJStwoViewController.h"
#import "LZBSweepView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<LZBDataModel *> *datas;

@property(nonatomic,strong) UIButton *sweepButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择类型";
    [self.view addSubview:self.tableView];
    self.datas = @[
    [[LZBDataModel alloc]initWithVC:[[LZBJStoOCFromURLMethodVC alloc]init] withTitle:@"JS调用OC-URL方法"],
    [[LZBDataModel alloc]initWithVC:[[LZBJStoOCFromJSContextViewController alloc]init] withTitle:@"JS调用OC第二方法(JavaScriptCore)"],
    [[LZBDataModel alloc]initWithVC:[[LZBOCtoJSOneViewController alloc]init] withTitle:@"OC调用JS第一方法"],
    [[LZBDataModel alloc]initWithVC:[[LZBOCtoJStwoViewController alloc]init]  withTitle:@"OC调用JS第二方法(JavaScriptCore)"],];
    [self addLeftSweepButton];
}

- (void)addLeftSweepButton
{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.sweepButton];
}
- (void)clickSweep
{
    LZBSweepView *sweepView = [[LZBSweepView alloc]init];
    [sweepView showInSuperView:nil];
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

- (UIButton *)sweepButton
{
  if(_sweepButton == nil)
  {
      _sweepButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [_sweepButton setTitle:@"点我惊喜" forState:UIControlStateNormal];
      [_sweepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
      _sweepButton.backgroundColor = [UIColor yellowColor];
      _sweepButton.frame =CGRectMake(0, 0, 100, 30);
      [_sweepButton addTarget:self action:@selector(clickSweep) forControlEvents:UIControlEventTouchUpInside];
  }
    return _sweepButton;
}





@end
