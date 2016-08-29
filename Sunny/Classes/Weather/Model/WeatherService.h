//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationService;
@class HTTPClient;

typedef void (^WeatherServiceCompletionBlock)(NSArray *items, NSError *error);

@interface WeatherService : NSObject
@property(nonatomic, strong, readonly) HTTPClient *httpClient;
@property(nonatomic, strong, readonly) LocationService *locationService;
@property(nonatomic, copy) WeatherServiceCompletionBlock weatherChangeUpdateBlock;

- (instancetype)initWithHttpClient:(HTTPClient *)httpClient locationService:(LocationService *)locationService;

- (BOOL)updateWeatherWithCompletion:(WeatherServiceCompletionBlock)completion;

@end
