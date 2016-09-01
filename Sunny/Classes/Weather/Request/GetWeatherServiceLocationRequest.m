//
//  GetWeatherServiceLocationRequest.m
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "GetWeatherServiceLocationRequest.h"
#import "HTTPClient.h"
#import "EXTScope.h"
#import "WeatherServiceLocation.h"
#import "WeatherServiceItem.h"

@interface GetWeatherServiceLocationRequest ()
@property(nonatomic, strong, readonly) NSDictionary *parameters;
@end

@implementation GetWeatherServiceLocationRequest

NSString *WeatherServiceOpenWeatherAPIBaseURL = @"http://api.openweathermap.org/data/2.5/weather";
NSString *WeatherServiceOpenWeatherAPPID = @"4e41c354247b9bff4a9fa26f51307ec7";

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        _parameters = [self parametersWithCoordinate:coordinate];
    }
    return self;
}

- (instancetype)initWithLocationID:(NSString *)locationID {
    self = [super init];
    if (self) {
        _parameters = [self parametersWithLocationID:locationID];
    }
    return self;
}

#pragma mark - Build and parse parameters

- (NSDictionary *)parametersWithCoordinate:(CLLocationCoordinate2D)coordinate {
    return @{
             @"lat" : @(coordinate.latitude),
             @"lon" : @(coordinate.longitude),
             };
}

- (NSDictionary *)parametersWithLocationID:(NSString *)locationID {
    return @{
             @"id" : locationID
             };
}

- (WeatherServiceLocation *)resultFromJSONObject:(id)jsonObject {
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *jsonDict = (NSDictionary *)jsonObject;
    //TODO: There should be some dictionary data type validation
    return
    [[WeatherServiceLocation alloc] initWithName:jsonDict[@"name"]
                                      identifier:jsonDict[@"id"]
                                           items:[self buildItemsFromJSON:jsonDict]];
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

#pragma mark -


- (NSURLSessionDataTask *)sendWithHTTPClient:(HTTPClient *)client completion:(void (^)(id, NSError *))completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"APPID" : WeatherServiceOpenWeatherAPPID}];
    [parameters addEntriesFromDictionary:self.parameters];
    return [client GET:WeatherServiceOpenWeatherAPIBaseURL
            parameters:parameters
            completion:^(id responseObject, NSError *error) {
                completion == nil ?:
                    completion([self resultFromJSONObject:responseObject], error);
            }];
}

@end
