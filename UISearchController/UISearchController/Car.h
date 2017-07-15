//
//  Car.h
//  UISearchController
//
//  Created by XingfuQiu on 2017/7/15.
//  Copyright © 2017年 XingfuQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *model;

+ (Car *) carWithName: (NSString *)name model: (NSString *)model;
@end
