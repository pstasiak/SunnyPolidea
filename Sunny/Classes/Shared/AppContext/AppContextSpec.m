#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "AppContext.h"
#import "WeatherViewController.h"
#import "WeatherDataSource.h"
#import "WeatherService.h"
#import "LocationService.h"

SpecBegin(AppContext)

describe(@"AppContext", ^{
    __block AppContext *appContext;

    beforeEach(^{
        appContext = [AppContext new];
    });

    afterEach(^{
        appContext = nil;
    });

    describe(@"weather view controller", ^{
        __block WeatherViewController *weatherViewController;

        beforeEach(^{
            weatherViewController = [appContext weatherViewController];
        });

        it(@"should be kind of proper class", ^{
            expect(weatherViewController).to.beKindOf([WeatherViewController class]);
        });

        it(@"should have data source set", ^{
            expect(weatherViewController.dataSource).to.beKindOf([WeatherDataSource class]);
        });

    });

    describe(@"weather data source", ^{
        __block WeatherDataSource *dataSource;

        beforeEach(^{
            dataSource = [appContext weatherDataSource];
        });

        it(@"should have data source with service set", ^{
            expect(dataSource.weatherService).to.beKindOf([WeatherService class]);
        });
    });

    describe(@"weather service", ^{
        __block WeatherService *weatherService;
        
        beforeEach(^{
            weatherService = [appContext weatherService];
        });

        it(@"should have location manager set", ^{
            expect(weatherService.locationService).to.beKindOf([LocationService class]);
        });
    });
});

SpecEnd
