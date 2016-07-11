//
//  LZBOCtoJStwoViewController.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBOCtoJStwoViewController.h"

@interface LZBOCtoJStwoViewController ()

@end

@implementation LZBOCtoJStwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC调用JS方法";
    [self loadWebData];
   
}

- (void)loadWebData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OCtoJSfirstIndex.html" ofType:nil];
    NSURL *localURL = [[NSURL alloc]initFileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
    
}

@end
