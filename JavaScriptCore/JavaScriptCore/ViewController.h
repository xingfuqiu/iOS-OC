//
//  ViewController.h
//  JavaScriptCore
//
//  Created by XingfuQiu on 2017/8/10.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController : UIViewController
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,weak) JSContext *context;

@end

