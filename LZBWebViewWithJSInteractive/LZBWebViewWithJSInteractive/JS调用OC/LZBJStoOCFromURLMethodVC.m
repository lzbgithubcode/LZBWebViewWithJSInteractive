//
//  LZBJStoOCFromURLMethodVC.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBJStoOCFromURLMethodVC.h"
#import <WebKit/WebKit.h>
#import "NSObject + MethodExtension.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface LZBJStoOCFromURLMethodVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LZBJStoOCFromURLMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self loadWeb];
   
}
- (void)loadWeb
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"firstIndex.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    self.webView.dataDetectorTypes = UIDataDetectorTypeLink;
}

#pragma mark - webView的delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSString *getURLString = [request.URL absoluteString];
    NSLog(@"总的字符串：%@",getURLString);
    
    NSString *htmlHeadString = @"zimu://";
    //协议头可以自己定义可以自己定义
    if([getURLString hasPrefix:htmlHeadString])
    {
        NSString *subString = [getURLString substringFromIndex:htmlHeadString.length];
        NSArray *arrayStr = [subString componentsSeparatedByString:@"?"];
        NSString *fistStr = [arrayStr firstObject];
        NSString *methodName = [fistStr stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        SEL  selector = NSSelectorFromString(methodName);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        //-Warc-performSelector-leaks为唯一的警告标识
       [self performSelector:selector withObject:[arrayStr lastObject]];
#pragma clang diagnostic pop
        
        //注意：系统提供的方法最多只有两个参数，如果要多个参数，使用我的扩展类
       // - (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects
        
        return NO;
    }
    else
       return YES;

}

- (void)callName:(NSString *)string
{
    NSLog(@"详细讲解网站是：\n%@",string);
}



#pragma mark - 懒加载
- (UIWebView *)webView
{
   if(_webView == nil)
   {
       _webView = [[UIWebView alloc]init];
       _webView.delegate =self;
       _webView.frame = self.view.bounds;
   }
    return _webView;
}





@end
