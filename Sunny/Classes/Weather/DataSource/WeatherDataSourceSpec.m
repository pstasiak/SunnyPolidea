#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import <UIKit/UIKit.h>
#import "WeatherDataSource.h"
#import "Metamacros.h"
#import "NSObject+Utilities.h"
#import "WeatherViewCell.h"
#import "WeatherService.h"
#import "NSInvocation+OCMockito.h"
#import "LocationService.h"

@interface WeatherDataSource (Spec) <UICollectionViewDataSource>
@end

SpecBegin(WeatherDataSource)

describe(@"WeatherDataSource", ^{
    __block WeatherDataSource *weatherDataSource;
    __block WeatherService *weatherService;

    beforeEach(^{
        weatherService = mock([WeatherService class]);
        weatherDataSource = [[WeatherDataSource alloc] initWithWeatherService:weatherService];
    });

    afterEach(^{
        weatherDataSource = nil;
    });

    describe(@"initialization", ^{
        it(@"should be a view binder", ^{
            expect(weatherDataSource).to.conformTo(@protocol(ViewBinder));
        });

        it(@"should be collection view data source", ^{
            expect(weatherDataSource).to.conformTo(@protocol(UICollectionViewDataSource));
        });

        it(@"should have weather service set", ^{
            expect(weatherDataSource.weatherService).to.equal(weatherService);
        });

        fit(@"should have set up update block on weather service", ^{
            [verify(weatherService) setWeatherChangeUpdateBlock:anything()];
        });
    });

    describe(@"view", ^{
        __block UICollectionView *collectionView;

        describe(@"binding", ^{
            beforeEach(^{
                collectionView = mock([UICollectionView class]);
                [weatherDataSource bindWithView:collectionView];
            });

            it(@"should set itself as a collection view data source", ^{
                [verify(collectionView) setDataSource:DynamicCast(weatherDataSource)];
            });

            it(@"should register default class", ^{
                [verify(collectionView) registerClass:[WeatherViewCell class]
                           forCellWithReuseIdentifier:[WeatherViewCell className]];
            });
        });
    });

    describe(@"updating data", ^{
        __block BOOL updateCompleted;
        __block NSArray *items;
        __block NSError *maybeError;

        beforeEach(^{
            items = @[@1, @2, @3];
            [given([weatherService updateWeatherWithCompletion:anything()]) willDo:^id(NSInvocation *invocation) {
                NSArray *args = [invocation mkt_arguments];
                WeatherServiceCompletionBlock completionBlock = args[0];
                completionBlock(items, nil);
                return @YES;
            }];

            [weatherDataSource updateWeatherWithCompletion:^(NSError *error) {
                maybeError = error;
                updateCompleted = YES;
            }];
        });

        it(@"should complete update", ^{
            expect(updateCompleted).to.beTruthy();
        });

        it(@"should complete without error", ^{
            expect(maybeError).to.beNil();
        });

        it(@"should have valid data", ^{
            expect(weatherDataSource.items).to.equal(items);
        });

        describe(@"configuring cell", ^{
            __block UICollectionView *collectionView;
            __block id <Configurable> configurableView;
            __block id expectedView;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];

            beforeEach(^{
                configurableView = mockProtocol(@protocol(Configurable));
                collectionView = mock([UICollectionView class]);
                [given([collectionView dequeueReusableCellWithReuseIdentifier:anything()
                                                                 forIndexPath:indexPath]) willReturn:configurableView];
                expectedView = [weatherDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
            });

            it(@"should return proper cell", ^{
                expect(expectedView).to.equal(configurableView);
            });

            it(@"should configure with proper item", ^{
                [verify(configurableView) configureWithItem:@1];
            });
        });
    });
});

SpecEnd
