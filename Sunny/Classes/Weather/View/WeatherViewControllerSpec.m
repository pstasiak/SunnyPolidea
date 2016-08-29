#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/NSInvocation+OCMockito.h>

#import "WeatherViewController.h"
#import "Metamacros.h"
#import "UIScrollView+EmptyDataSet.h"
#import "WeatherDataSource.h"

SpecBegin(WeatherViewController)

describe(@"WeatherViewController", ^{
    __block WeatherViewController *weatherViewController;
    __block WeatherDataSource *weatherDataSource;

    beforeEach(^{
        weatherDataSource = mock([WeatherDataSource class]);
        weatherViewController = [[WeatherViewController alloc] initWithDataSource:weatherDataSource];
    });
    
    afterEach(^{
        weatherViewController = nil;
    });

    describe(@"initialization", ^{
        it(@"should have proper title", ^{
            expect(weatherViewController.title).to.equal(NSLocalizedString(@"Sunny", @"Sunny"));
        });

        it(@"should have set weather data source", ^{
            expect(weatherViewController.dataSource).to.equal(weatherDataSource);
        });
    });
    
    describe(@"view", ^{
        __block UICollectionView *collectionView;

        beforeEach(^{
            collectionView = DynamicCast(weatherViewController.view);
        });

        it(@"should be a collection view", ^{
            expect(collectionView).to.beKindOf([UICollectionView class]);
        });

        it(@"should be bound to data source", ^{
            [verify(weatherDataSource) bindWithView:collectionView];
        });

        it(@"should have delegate set", ^{
            expect(collectionView.delegate).to.equal(weatherViewController);
        });

        describe(@"layout", ^{
            __block UICollectionViewFlowLayout *layout;

            beforeEach(^{
                layout = DynamicCast(collectionView.collectionViewLayout);
            });

            it(@"should be a flow layout", ^{
                expect(layout).to.beKindOf([UICollectionViewFlowLayout class]);
            });

            it(@"should have vertical scroll direction", ^{
                expect(layout.scrollDirection).to.equal(UICollectionViewScrollDirectionVertical);
            });
        });

        describe(@"empty data set", ^{
            it(@"should have delegate set", ^{
                expect(collectionView.emptyDataSetDelegate).to.equal(weatherViewController);
            });

            it(@"should have data source set", ^{
                expect(collectionView.emptyDataSetSource).to.equal(weatherViewController);
            });
        });
    });

    describe(@"refreshing data", ^{
        __block UICollectionView *collectionView;

        beforeEach(^{
            // Mock data source call
            [given([weatherDataSource updateWeatherWithCompletion:anything()]) willDo:^id(NSInvocation *invocation) {
                NSArray *args = [invocation mkt_arguments];
                WeatherDataSourceCompletionBlock completionBlock = args[0];
                completionBlock(nil);
                return @YES;
            }];
        });

        context(@"on load", ^{
            beforeEach(^{
                collectionView = DynamicCast(weatherViewController.view);
                collectionView.dataSource = DynamicCast(weatherDataSource);
                [weatherViewController viewDidLoad];
            });

            it(@"should reload collection view", ^{
                [verifyCount(weatherDataSource, atLeastOnce()) collectionView:collectionView numberOfItemsInSection:0];
            });
        });

        context(@"on refresh action", ^{
            beforeEach(^{
                collectionView = DynamicCast(weatherViewController.view);
                collectionView.dataSource = DynamicCast(weatherDataSource);

                // Get refresh control
                __block UIRefreshControl *refreshControl;
                for (id subview in collectionView.subviews) {
                    if ([subview isKindOfClass:[UIRefreshControl class]]) {
                        refreshControl = subview;
                        break;
                    }
                }

                // Simulate refresh action
                [refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
            });

            it(@"should reload collection view", ^{
                [verifyCount(weatherDataSource, atLeastOnce()) collectionView:collectionView numberOfItemsInSection:0];
            });
        });
    });
});

SpecEnd
