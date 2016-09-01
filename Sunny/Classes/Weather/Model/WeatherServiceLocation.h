//
//  WeatherServiceLocation.h
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherServiceItem;

@interface WeatherServiceLocation : NSObject

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSNumber *identifier;
@property(nonatomic, copy, readonly) NSArray<WeatherServiceItem *> *items;

NS_ASSUME_NONNULL_END

- (nullable instancetype)initWithName:(nullable NSString *)name
                           identifier:(nullable NSNumber *)identifier
                                items:(nullable NSArray<WeatherServiceItem *> *) items;

@end
