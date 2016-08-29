#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import <CoreLocation/CoreLocation.h>
#import "LocationService.h"

@interface LocationService (Spec) <CLLocationManagerDelegate>
@property(nonatomic, strong, readonly) CLLocationManager *locationManager;
@end

SpecBegin(LocationService)

describe(@"LocationService", ^{
    __block LocationService *locationService;

    beforeEach(^{
        locationService = [LocationService new];
    });

    afterEach(^{
        locationService = nil;
    });

    describe(@"initialization", ^{
        it(@"should be not enabled by default", ^{
            expect(locationService.enabled).to.beFalsy();
        });
    });

    describe(@"internal location manager", ^{
        __block CLLocationManager *locationManager;

        describe(@"configuration", ^{
            beforeEach(^{
                locationManager = locationService.locationManager;
            });

            it(@"should be a location manager indeed", ^{
                expect(locationManager).to.beKindOf([CLLocationManager class]);
            });

            it(@"should have distance filter set", ^{
                expect(locationManager.distanceFilter).to.equal(100);
            });

            it(@"should have desired accuracy set", ^{
                expect(locationManager.desiredAccuracy).to.equal(kCLLocationAccuracyBest);
            });

            it(@"should have delegate set", ^{
                expect(locationManager.delegate).to.equal(locationService);
            });
        });

        describe(@"behavior", ^{
            beforeEach(^{
                locationManager = mock([CLLocationManager class]);
                [locationService setValue:locationManager forKey:NSStringFromSelector(@selector(locationManager))];
            });

            describe(@"enabled", ^{
                it(@"should start updating location when enabled", ^{
                    locationService.enabled = YES;
                    [verify(locationManager) startUpdatingLocation];
                });

                it(@"should stop update location when disabled", ^{
                    locationService.enabled = YES; // To reset
                    locationService.enabled = NO;
                    [verify(locationManager) stopUpdatingLocation];
                });
            });
        });
    });

    describe(@"notifying delegate about the changes", ^{
        __block CLLocation *updatedLocation;
        __block CLLocation *expectedLocation = [[CLLocation alloc] initWithLatitude:20
                                                                          longitude:20];

        beforeEach(^{
            locationService.onUpdateBlock = ^(CLLocation *location, NSError *error) {
                updatedLocation = location;
            };
            [locationService locationManager:nil didUpdateLocations:@[expectedLocation]];
        });

        it(@"should notify observer on update", ^{
            expect(updatedLocation).to.equal(expectedLocation);
        });
    });
});

SpecEnd
