//
//  LZBOCtoJSOneViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBOCtoJSOneViewController.h"

#define button_Width   100
#define button_Height  30

@interface LZBOCtoJSOneViewController ()

@property (nonatomic, strong) UIButton *btn;
@end

@implementation LZBOCtoJSOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC调用JS方法";
    [self loadWebData];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:self.btn]];
}

- (void)loadWebData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OCtoJSfirstIndex.html" ofType:nil];
    NSURL *localURL = [[NSURL alloc]initFileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
    
}

- (void)callJS
{
    NSString *param = @"OC调用JS参数http://www.jianshu.com/users/d21698127416/latest_articles";
    NSString *js = [NSString stringWithFormat:@"callJS('%@')",param];
   NSString *string = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"%@",string);
   
}


- (UIButton *)btn
{
  if(_btn == nil)
  {
      _btn = [UIButton buttonWithType:UIButtonTypeCustom];
      _btn.backgroundColor = [UIColor greenColor];
      _btn.frame = CGRectMake(self.view.center.x - button_Width * 0.5, self.view.center.y, button_Width, button_Height);
      [_btn setTitle:@"点击调用JS" forState:UIControlStateNormal];
      [_btn addTarget:self action:@selector(callJS) forControlEvents:UIControlEventTouchUpInside];
  }
    return _btn;
}




@end
