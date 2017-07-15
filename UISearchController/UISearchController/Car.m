//
//  Car.m
//  UISearchController
//
//  Created by XingfuQiu on 2017/7/15.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import "Car.h"

@implementation Car

+ (Car *) carWithName:(NSString *)name model:(NSString *)model {
    Car * car = [[Car alloc] init];
    car.name = name;
    car.model = model;
    
    return car;
}

@end
