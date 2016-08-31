//
//  MainCoordinator.m
//  Sunny
//
//  Created by Przemek on 29.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "MainCoordinator.h"
#import "WeatherViewController.h"
#import "AppContext.h"
#import "Pages-Swift.h"
#import "ColorScheme.h"
#import "LocationSearchViewController.h"

@interface MainCoordinator ()
@property(nonatomic, strong, readonly) AppContext *appContext;
@property(nonatomic, strong, readonly) UIWindow *window;
@end

@implementation MainCoordinator

MM_NOT_DESIGNATED_INITIALIZER()

- (instancetype)initWithAppContext:(AppContext *)appContext
                            window:(UIWindow *)window {
    NSParameterAssert(appContext);
    NSParameterAssert(window);
    
    self = [super init];
    if (self) {
        _appContext = appContext;
        _window = window;
    }
    return self;
}

- (void)start {
    WeatherViewController *weatherViewController = [self.appContext weatherViewController];
    HYPPagesController *pagesController = [[HYPPagesController alloc] init:@[weatherViewController]
                                                           transitionStyle:UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                   options:nil];
    pagesController.edgesForExtendedLayout = UIRectEdgeNone;
    pagesController.view.backgroundColor = self.appContext.colorScheme.mainBackgroundColor;
    pagesController.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                  target:self
                                                  action:@checkselector(self, didTapSearchButton:)];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:pagesController];
    [self.window makeKeyAndVisible];
}

#pragma mark - NavigationBarItems

- (void)didTapSearchButton:(id)sender {
    LocationSearchViewController *searchVC = [LocationSearchViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self.window.rootViewController presentViewController:navVC animated:YES completion:nil];
}

@end
