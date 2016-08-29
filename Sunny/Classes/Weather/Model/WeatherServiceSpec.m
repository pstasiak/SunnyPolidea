#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "WeatherService.h"
#import "LocationService.h"
#import "HTTPClient.h"
#import "NSInvocation+OCMockito.h"
#import "SampleJSONServer.h"
#import "LocationServiceFake.h"
#import "Metamacros.h"
#import "WeatherServiceItem.h"

@interface WeatherService (Specs)
- (NSDictionary *)parametersForLocation:(CLLocation *)location;
@end

SpecBegin(WeatherService)

describe(@"WeatherService", ^{
    __block WeatherService *weatherService;
    __block LocationService *locationService;
    __block HTTPClient *httpClient;

    beforeEach(^{
        LocationServiceFake *serviceFake = [LocationServiceFake new];
        serviceFake.currentLocation = [[CLLocation alloc] initWithLatitude:10
                                                                 longitude:11];
        locationService = DynamicCast(serviceFake);
        httpClient = mock([HTTPClient class]);
        weatherService = [[WeatherService alloc] initWithHttpClient:httpClient
                                                    locationService:locationService];
    });

    afterEach(^{
        weatherService = nil;
    });

    describe(@"initialization", ^{
        it(@"should have location service set", ^{
            expect(weatherService.locationService).to.equal(locationService);
        });

        it(@"should have set http client", ^{
            expect(weatherService.httpClient).to.equal(httpClient);
        });
    });

    describe(@"fetching weather data", ^{
        __block NSArray *updatedItems;

        beforeEach(^{
            NSDictionary *parameters = [weatherService parametersForLocation:[[CLLocation alloc] initWithLatitude:10 longitude:11]];
            [given([httpClient GET:anything() parameters:parameters
                           success:anything() failure:anything()])
                    willDo:^id(NSInvocation *invocation) {
                        NSArray *arguments = invocation.mkt_arguments;
                        id successBlockRef = arguments[2];
                        void (^successBlock)(NSURLSessionDataTask *task, NSDictionary *json) = successBlockRef;
                        successBlock(nil, [SampleJSONServer sampleWeatherJSON]);
                        return @YES;
                    }];

            [weatherService updateWeatherWithCompletion:^(NSArray *items, NSError *error) {
                updatedItems = items;
            }];
        });

        it(@"should have 5 items", ^{
            expect(updatedItems.count).to.equal(5);
        });

        it(@"should have first item temperature", ^{
            WeatherServiceItem *serviceItem = updatedItems.firstObject;
            expect(serviceItem.name).to.equal(@"Temperature");
            expect(serviceItem.value).to.equal(@"289.5");
        });
    });
});

SpecEnd
