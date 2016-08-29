//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "WeatherServiceItem.h"

@implementation WeatherServiceItem

+ (instancetype)itemWithName:(NSString *)name value:(id)value type:(WeatherServiceItemType)type {
    return [[self alloc] initWithName:name value:value type:type];
}

- (instancetype)initWithName:(NSString *)name value:(id)value type:(WeatherServiceItemType)type {
    self = [super init];
    if (self) {
        _name = [name copy];
        _value = [value isKindOfClass:[NSNumber class]] ? [(NSNumber *) value stringValue] : value;
        _type = type;
    }

    return self;
}

- (NSString *)formattedValue {
    static NSDictionary *suffixes = nil;
    if (!suffixes) {
        suffixes = @{
                REFStringForMemberInWeatherServiceItemType(WeatherServiceItemTypeNone) : @"",
                REFStringForMemberInWeatherServiceItemType(WeatherServiceItemTypeTemperature) : @"°F",
                REFStringForMemberInWeatherServiceItemType(WeatherServiceItemTypePressure) : @"hpa",
                REFStringForMemberInWeatherServiceItemType(WeatherServiceItemTypeHumidity) : @"%",
        };
    }
    return [NSString stringWithFormat:@"%@ %@", self.value, suffixes[REFStringForMember(self.type)]];
}

@end
