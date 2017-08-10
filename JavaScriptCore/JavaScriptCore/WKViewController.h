//
//  WKViewController.h
//  JavaScriptCore
//
//  Created by XingfuQiu on 2017/8/10.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DetailsViewController.h"

@interface WKViewController : UIViewController <WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end
