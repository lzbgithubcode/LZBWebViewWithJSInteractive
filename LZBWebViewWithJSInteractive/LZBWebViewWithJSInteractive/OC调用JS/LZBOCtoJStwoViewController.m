//
//  LZBOCtoJStwoViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBOCtoJStwoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define button_Width   100
#define button_Height  30
@interface LZBOCtoJStwoViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation LZBOCtoJStwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC调用JS方法";
    [self loadWebData];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:self.btn]];
   
}

- (void)loadWebData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OCtoJStwoIndex.html" ofType:nil];
    NSURL *localURL = [[NSURL alloc]initFileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
}

- (void)handdleOCCallJS
{
  //获得WebView的运行环境的对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //调用方法（注意：这里是JS里面的定义的方法）
    NSString *callJSstring = @"sendJSString('参数：OC call JS test 子木')";
    
    [context evaluateScript:callJSstring];
}

- (UIButton *)btn
{
    if(_btn == nil)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor redColor];
        _btn.frame = CGRectMake(self.view.center.x - button_Width * 0.5, self.view.center.y, button_Width, button_Height);
        [_btn setTitle:@"点击调用JS" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handdleOCCallJS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
