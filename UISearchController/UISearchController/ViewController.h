//
//  ViewController.h
//  UISearchController
//
//  Created by XingfuQiu on 2017/7/15.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cars;
@property (nonatomic, strong) NSArray *filteredCars;

@property (nonatomic, retain) UISearchController *searchController;


@property (nonatomic, strong) NSMutableArray *alphabetArray;
@property (nonatomic, strong) NSArray *filteredAlphabetArray;

@end

