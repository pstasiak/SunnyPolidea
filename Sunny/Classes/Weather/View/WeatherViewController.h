//
// Created by Maciej Oczko on 22/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WeatherDataSource;

@interface WeatherViewController : UIViewController
@property(nonatomic, strong, readonly) WeatherDataSource *dataSource;

- (instancetype)initWithDataSource:(WeatherDataSource *)dataSource;

@end
