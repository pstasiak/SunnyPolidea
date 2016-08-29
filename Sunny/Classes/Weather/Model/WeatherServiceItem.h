//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReflectableEnum.h"

REFLECTABLE_ENUM(NSInteger, WeatherServiceItemType,
        WeatherServiceItemTypeNone,
        WeatherServiceItemTypeTemperature,
        WeatherServiceItemTypeHumidity,
        WeatherServiceItemTypePressure,
);

@interface WeatherServiceItem : NSObject
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *value;
@property(nonatomic, assign, readonly) WeatherServiceItemType type;

+ (instancetype)itemWithName:(NSString *)name value:(id)value type:( WeatherServiceItemType)type;
- (instancetype)initWithName:(NSString *)name value:(id)value type:(WeatherServiceItemType)type;

- (NSString *)formattedValue;

@end
