//
//  GetWeatherServiceLocationRequest.h
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "HTTPRequest.h"
#import <CoreLocation/CoreLocation.h>

@class WeatherServiceLocation;

NS_ASSUME_NONNULL_BEGIN

@interface GetWeatherServiceLocationRequest : HTTPRequest<WeatherServiceLocation *>

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (instancetype)initWithLocationID:(NSString *)locationID;

@end

NS_ASSUME_NONNULL_END
