//
// Created by Maciej Oczko on 26/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationServiceUpdateBlock)(CLLocation *location, NSError *error);

@interface LocationService : NSObject
@property(nonatomic, assign, getter=isEnabled) BOOL enabled;
@property(nonatomic, strong, readonly) CLLocation *currentLocation;
/*
    After setting block the service will refresh/reload.
 */
@property(nonatomic, copy) LocationServiceUpdateBlock onUpdateBlock;
@end
