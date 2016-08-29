//
// Created by Maciej Oczko on 26/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "LocationService.h"
#import "Metamacros.h"

@interface LocationService () <CLLocationManagerDelegate>
@property(nonatomic, strong, readwrite) CLLocationManager *locationManager;
@property(nonatomic, strong, readwrite) CLLocation *currentLocation;
@property(nonatomic, strong, readwrite) NSError *error;
@end

@implementation LocationService

LazyProperty(CLLocationManager *, locationManager, ^{
    CLLocationManager *locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 100;
    if(![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location services are not available.");
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    return locationManager;
})

#pragma mark - Location update logic

- (void)setEnabled:(BOOL)enabled {
    if (_enabled == enabled) {
        return;
    }
    _enabled = enabled;
    if (enabled) {
        NSLog(@"Starting updating location...");
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Stopping updating location...");
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)setCurrentLocation:(CLLocation *)currentLocation {
    _currentLocation = currentLocation;
    if (self.onUpdateBlock) {
        self.onUpdateBlock(currentLocation, self.error);
    }
}

- (void)setOnUpdateBlock:(LocationServiceUpdateBlock)onUpdateBlock {
    self.enabled = NO;
    _onUpdateBlock = [onUpdateBlock copy];
    self.enabled = YES;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Did update locations.");
    self.error = nil;
    self.currentLocation = locations.lastObject;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed updating locations = %@", error.localizedDescription);
    self.error = error;
    self.currentLocation = nil;
}

@end
