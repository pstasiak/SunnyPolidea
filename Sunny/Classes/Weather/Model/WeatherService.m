//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "WeatherService.h"
#import "LocationService.h"
#import "HTTPClient.h"
#import "WeatherServiceItem.h"

NSString *WeatherServiceOpenWeatherAPIBaseURL = @"http://api.openweathermap.org/data/2.5/weather";
NSString *WeatherServiceOpenWeatherAPPID = @"4e41c354247b9bff4a9fa26f51307ec7";

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
    @weakify(self)
    [self.httpClient GET:WeatherServiceOpenWeatherAPIBaseURL
              parameters:[self parametersForLocation:location]
                 success:^(NSURLSessionDataTask *task, NSDictionary *json) {
                     @strongify(self)
                     if (completion) {
                         completion([self buildItemsFromJSON:json], nil);
                     }
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     if (completion) {
                         completion(nil, error);
                     }
                 }];
}

- (NSArray *)buildItemsFromJSON:(NSDictionary *)json {
    NSDictionary *mainInformation = json[@"main"];
    return @[
            [WeatherServiceItem itemWithName:@"Temperature" value:mainInformation[@"temp"] type:WeatherServiceItemTypeTemperature],
            [WeatherServiceItem itemWithName:@"Humidity" value:mainInformation[@"humidity"] type:WeatherServiceItemTypeHumidity],
            [WeatherServiceItem itemWithName:@"Pressure" value:mainInformation[@"pressure"] type:WeatherServiceItemTypePressure],
            [WeatherServiceItem itemWithName:@"Min. temperature" value:mainInformation[@"temp_min"] type:WeatherServiceItemTypeTemperature],
            [WeatherServiceItem itemWithName:@"Max. temperature" value:mainInformation[@"temp_max"] type:WeatherServiceItemTypeTemperature],
    ];
}

- (NSDictionary *)parametersForLocation:(CLLocation *)location {
    return @{
            @"lat" : @(location.coordinate.latitude),
            @"lon" : @(location.coordinate.longitude),
            @"APPID" : WeatherServiceOpenWeatherAPPID,
    };
}

@end
