//
//  WeatherServiceLocation.m
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "WeatherServiceLocation.h"

@implementation WeatherServiceLocation

- (nullable instancetype)initWithName:(nullable NSString *)name
                           identifier:(nullable NSNumber *)identifier
                                items:(nullable NSArray<WeatherServiceItem *> *) items {
    if (name && identifier && items) {
        self = [super init];
        if (self) {
            _name = [name copy];
            _identifier = [identifier copy];
            _items = [items copy];
        }
    }
    return self;
}

@end
