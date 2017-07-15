//
//  ViewController.m
//  UISearchController
//
//  Created by XingfuQiu on 2017/7/15.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchDisplayDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化数据
    self.cars = [[NSArray alloc] initWithObjects:
                 [Car carWithName:@"ASD" model:@"???"],
                 [Car carWithName:@"BMW" model:@"320i"],
                 [Car carWithName:@"BMW" model:@"320Li"],
                 [Car carWithName:@"BMW" model:@"328i"],
                 [Car carWithName:@"BMW" model:@"320Li"],
                 [Car carWithName:@"BMW" model:@"320iM"],
                 [Car carWithName:@"BMW" model:@"520"],
                 [Car carWithName:@"CHANGAN" model:@"C200"],
                 [Car carWithName:@"ZONGTAI" model:@"T700"],
                 nil];
    
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    //创建tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, appFrame.size.width, appFrame.size.height - 20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //创建searchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"输入品牌或型号";
    //设置tableview的搜索栏
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];//设置索引条的背景颜色
    
    //设置字母表
    self.alphabetArray = [self getAlphetSortedArray];

}

/**
 * 新添加方法：
 * 获取字母表
 * @return MSMutableArray* 已经排序的字母表数组
 */
- (NSMutableArray *) getAlphetSortedArray {
    self.alphabetArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.cars count]; i ++) {
        //获取名字的第一个字母
        Car *car = [self.cars objectAtIndex:i];
        char letter = [car.name characterAtIndex:0];
        NSString *uniqueChar = [NSString stringWithFormat:@"%c", letter];
        //将字母加入到字母表中
        if (![self.alphabetArray containsObject:uniqueChar]) {
            [self.alphabetArray addObject:uniqueChar];
        }
    }
    
    //对字母表进行排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *sortDescirptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [self.alphabetArray sortedArrayUsingDescriptors:sortDescirptors];
    NSMutableArray *alphabetArray = [[NSMutableArray alloc] initWithArray:sortedArray copyItems:YES];
    
    return alphabetArray;
}
#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [self.filteredCars count];
    } else {
        NSArray *tmpArray = [self getAlphabetArrayWithIndex:section];
        
        return [tmpArray count];
    }
}

#pragma mark - Indexing UITableView
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.alphabetArray;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - tableView
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.alphabetArray objectAtIndex: section];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.searchController.active) {
        self.alphabetArray = nil;//搜索时不显示section
        return 1;
    } else {
        self.alphabetArray = [self getAlphetSortedArray];//停止搜索恢复section显示
        return [self.alphabetArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    Car *car;
    if (self.searchController.active) {
        car = [self.filteredCars objectAtIndex:indexPath.row];
    } else {
        
        NSArray *tmpArray = [self getAlphabetArrayWithIndex:indexPath.section];
        if ([tmpArray count]) {
            car = [tmpArray objectAtIndex:indexPath.row];
        }
        
    }
    
    if (car) {
        cell.textLabel.text = car.name;
        cell.detailTextLabel.text = car.model;
    }
    
    return cell;
    
}

/*
 * 新添加方法：
 * 根据首字母对所有车辆进行筛选
 * @return NSArray* 于当前首字母相同的车辆数组
 */

- (NSArray *) getAlphabetArrayWithIndex:(NSInteger)index{
    
    NSString *alphabet = [self.alphabetArray objectAtIndex:index];
    NSPredicate *car = [NSPredicate predicateWithFormat:@"name BEGINSWITH [cd] %@", alphabet];
    NSArray *tmpArray = [self.cars filteredArrayUsingPredicate:car];
    
    return tmpArray;
}

#pragma mark - SearchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR model CONTAINS[cd] %@", searchString, searchString];
    
    self.filteredCars = [self.cars filteredArrayUsingPredicate:predicate];
    
    //刷新表格
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
