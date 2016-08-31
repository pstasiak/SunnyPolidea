//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "AppContext.h"
#import "WeatherViewController.h"
#import "WeatherDataSource.h"
#import "WeatherService.h"
#import "LocationService.h"
#import "HTTPClient.h"
#import "ColorScheme.h"

@implementation AppContext

- (id<ColorSchemeProtocol>)colorScheme {
    return [ColorScheme new];
}

- (WeatherViewController *)weatherViewController {
    return [[WeatherViewController alloc] initWithDataSource:[self weatherDataSource]];
}

- (WeatherDataSource *)weatherDataSource {
    return [[WeatherDataSource alloc] initWithWeatherService:[self weatherService]];
}

- (WeatherService *)weatherService {
    return [[WeatherService alloc] initWithHttpClient:[self httpClient] locationService:[self locationService]];
}

- (HTTPClient *)httpClient {
    return [HTTPClient new];
}

- (LocationService *)locationService {
    return [LocationService new];
}

@end
