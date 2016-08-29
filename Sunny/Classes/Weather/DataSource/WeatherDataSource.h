//
// Created by Maciej Oczko on 22/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewBinder.h"

@class WeatherService;

typedef void (^WeatherDataSourceCompletionBlock)(NSError *error);

@interface WeatherDataSource : NSObject <ViewBinder>
@property(nonatomic, strong, readonly) WeatherService *weatherService;
@property(nonatomic, strong, readonly) NSArray *items;
@property(nonatomic, copy) WeatherDataSourceCompletionBlock updateCompletionBlock;

- (instancetype)initWithWeatherService:(WeatherService *)weatherService;
- (BOOL)updateWeatherWithCompletion:(WeatherDataSourceCompletionBlock)completion;

@end
