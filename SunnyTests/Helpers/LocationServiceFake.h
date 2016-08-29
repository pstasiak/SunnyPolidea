//
// Created by Maciej Oczko on 06/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationService.h"

@interface LocationServiceFake : NSObject
@property(nonatomic, strong) CLLocation *currentLocation;
@property(nonatomic, strong) NSError *error;
@end
