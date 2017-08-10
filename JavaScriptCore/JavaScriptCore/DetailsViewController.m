//
//  DetailsViewController.m
//  JavaScriptCore
//
//  Created by XingfuQiu on 2017/8/10.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"%@'s age is:%@", _name, _age);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
