//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherViewController;
@class WeatherDataSource;
@class WeatherService;
@class LocationService;
@protocol ColorSchemeProtocol;

@interface AppContext : NSObject

- (id<ColorSchemeProtocol>)colorScheme;
- (WeatherViewController *)weatherViewController;
- (WeatherDataSource *)weatherDataSource;
- (WeatherService *)weatherService;
- (LocationService *)locationService;

@end
