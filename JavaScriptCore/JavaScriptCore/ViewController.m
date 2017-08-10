//
//  ViewController.m
//  JavaScriptCore
//
//  Created by XingfuQiu on 2017/8/10.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import "ViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个webView来加载html
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, kWidth, kHeight - 50);
    _webView.delegate = self;
    [self.view addSubview:_webView];
    //先加载一个本地的html
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html/index" ofType:@"html"];
    NSLog(@"%@",path);
    NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
    //    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    //创建两个原生button,演示调用js方法
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, kHeight - 50, kWidth/2 - 0.5, 50);
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 setTitle:@"OC调用无参JS" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kWidth/2 + 1, kHeight - 50, kWidth/2 - 0.5, 50);
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 setTitle:@"OC调用JS(传参)" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

#pragma 供JS调用的方法
-(void)menthod1{
    NSLog(@"JS调用了无参数OC方法");
}
-(void)menthod2:(NSString *)str1 and:(NSString *)str2{
    NSLog(@"%@ %@",str1,str2);
}

#pragma OC调用JS方法
-(void)function1{
    [_webView stringByEvaluatingJavaScriptFromString:@"aaa()"];
}
-(void)function2{
    NSString *name = @"XingfuQiu";
    NSInteger num = 520;
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"bbb('%@','%ld');",name,num]];
}

#pragma UIWebViewDelegate 方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"开始响应请求时触发");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载网页");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完毕");
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //html调用无参数OC
    _context[@"test1"] = ^(){
        [self menthod1];
    };
    //html调用OC(传参数过来)
    _context[@"test2"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
        //        for (id  obj in args) {
        //            NSLog(@"html传过来的参数%@",obj);
        //        }
        NSString *name = args[0];
        NSString *str = args[1];
        [self menthod2:name and:str];
    };
    
    
    //OC调用JS方法
    //1.直接调用
    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
    [_context evaluateScript:alertJS];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网页加载出错");
}


@end
