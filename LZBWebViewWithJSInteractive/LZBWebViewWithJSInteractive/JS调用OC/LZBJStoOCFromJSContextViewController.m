//
//  LZBJStoOCFromJSContextViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBJStoOCFromJSContextViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@protocol LZBJSExport <JSExport>

- (void)callChangeColor;

@end

@interface LZBJStoOCFromJSContextViewController ()<LZBJSExport>

@end

@implementation LZBJStoOCFromJSContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebData];
    //1.block方式
    [self handleJScallOC];
    //2.协议的方式
   // [self regiseterResponser];
}

- (void)loadWebData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOCtwoIndex.html" ofType:nil];
    NSURL *localURL = [[NSURL alloc]initFileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
}

- (void)handleJScallOC
{
    //拿到WebView执行JS的执行环境，很重要的东西
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //点击了无参数，jstoocNoPrams是JS的方法名称
    context[@"jstoocNoPrams"] = ^(){
        NSLog(@"点击了没有传参数按钮");
        [LZBAlterView lzb_alterViewWithText:@"点击了没有参数按钮" OneTitle:@"知道了" TwoTitle:nil ThreeTitle:nil handleBlock:^(LZBAlterView *alterView, NSInteger btntag) {
            [alterView removeAlterView];
        }];
    };
    
    
   //点击传参数 jstoocHavePrams方法名称
    context[@"jstoocHavePrams"] = ^(){
        //获得参数
        NSArray *prams = [JSContext currentArguments];
        
        NSString *arraySting = [[NSString alloc]init];
        for (id obj in prams) {
            NSLog(@"====%@",obj);
            arraySting = [arraySting stringByAppendingFormat:@"%@,",obj];
        }
        
        [LZBAlterView lzb_alterViewWithText:@"点击了传参数按钮" OneTitle:arraySting TwoTitle:@"知道了" ThreeTitle:nil handleBlock:^(LZBAlterView *alterView, NSInteger btntag) {
            [alterView removeAlterView];
        }];
    };
}


#pragma mark - 第二种方式JSEport协议方式
- (void)regiseterResponser
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context setObject:self forKeyedSubscript:@"change"];
}

- (void)callChangeColor
{
    self.webView.backgroundColor = [UIColor redColor];
}



@end
