//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "WeatherService.h"
#import "LocationService.h"
#import "HTTPClient.h"
#import "WeatherServiceLocation.h"
#import "GetWeatherServiceLocationRequest.h"

@implementation WeatherService

- (instancetype)initWithHttpClient:(HTTPClient *)httpClient locationService:(LocationService *)locationService {
    self = [super init];
    if (self) {
        _httpClient = httpClient;
        _locationService = locationService;
        [self setUp];
    }

    return self;
}

- (void)setUp {
    @weakify(self)
    self.locationService.onUpdateBlock = ^(CLLocation *location, NSError *error) {
        @strongify(self)
        WeatherServiceCompletionBlock currentUpdateBlock = self.weatherChangeUpdateBlock;
        if (!currentUpdateBlock) {
            NSLog(@"Weather change update block is missing");
            return;
        }
        if (error) {
            currentUpdateBlock(nil, error);
        } else {
            [self fetchWeatherDataWithLocation:location completion:currentUpdateBlock];
        }
    };
}

- (BOOL)updateWeatherWithCompletion:(WeatherServiceCompletionBlock)completion {
    if (!completion) {
        return NO;
    }
    [self fetchWeatherDataWithLocation:self.locationService.currentLocation completion:completion];
    return YES;
}

- (void)fetchWeatherDataWithLocation:(CLLocation *)location completion:(WeatherServiceCompletionBlock)completion {
    NSParameterAssert(completion);
    NSLog(@"Fetching data for location = %@", location);
    GetWeatherServiceLocationRequest *request = [[GetWeatherServiceLocationRequest alloc] initWithCoordinate:location.coordinate];
    [request sendWithHTTPClient:self.httpClient
                     completion:^(WeatherServiceLocation *result, NSError *error) {
                         completion == nil ?: completion(result.items, error);
                     }];
}

@end
