#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "AppDelegate.h"
#import "Metamacros.h"
#import "AppContext.h"

SpecBegin(AppDelegate)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;
    __block AppContext *appContext;

    beforeEach(^{
        appContext = mock([AppContext class]);
        appDelegate = [AppDelegate new];
    });

    afterEach(^{
        appDelegate = nil;
    });

    describe(@"initialization", ^{
        it(@"should have proper app context set", ^{
            expect(appDelegate.appContext).to.beKindOf([AppContext class]);
        });
    });

    describe(@"did finish launching with options", ^{
        __block UIViewController *viewController;

        beforeEach(^{
            viewController = [UIViewController new];
            [given([appContext weatherViewController]) willReturn:viewController];
            [appDelegate setValue:appContext forKey:PropertyName(appContext)];

            [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        });

        describe(@"window", ^{
            it(@"should not nil", ^{
                expect(appDelegate.window).notTo.beNil();
            });
        });

        describe(@"root view controller", ^{
            __block UINavigationController *rootViewController;

            beforeEach(^{
                rootViewController = DynamicCast(appDelegate.window.rootViewController);
            });

            it(@"should be kind of navigation controller", ^{
                expect(rootViewController).to.beKindOf([UINavigationController class]);
            });

            it(@"should have proper controller as most top one", ^{
                expect(rootViewController.topViewController).to.equal(viewController);
            });
        });
    });
});

SpecEnd
