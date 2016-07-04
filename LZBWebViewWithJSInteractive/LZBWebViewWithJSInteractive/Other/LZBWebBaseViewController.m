//
//  LZBWebBaseViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBWebBaseViewController.h"


#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface LZBWebBaseViewController ()<UIWebViewDelegate>



@end

@implementation LZBWebBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
}
#pragma mark - 懒加载
- (UIWebView *)webView
{
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc]init];
        _webView.delegate =self;
        _webView.frame = self.view.bounds;
        _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    }
    return _webView;
}

@end
