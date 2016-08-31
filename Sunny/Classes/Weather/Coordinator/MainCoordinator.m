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
#import "IQKeyboardManager.h"
#import "LocationSearchViewModel.h"

@interface MainCoordinator ()
@property(nonatomic, strong, readonly) AppContext *appContext;
@property(nonatomic, strong, readonly) UIWindow *window;
@property(nonatomic, strong, readwrite) IQKeyboardManager *keyboardManager;
@end

@implementation MainCoordinator

MM_NOT_DESIGNATED_INITIALIZER()

- (instancetype)initWithAppContext:(AppContext *)appContext
                            window:(UIWindow *)window {
    return [self initWithAppContext:appContext
                             window:window
                    keyboardManager:[IQKeyboardManager sharedManager]];
}

- (instancetype)initWithAppContext:(AppContext *)appContext
                            window:(UIWindow *)window
                   keyboardManager:(IQKeyboardManager *)keyboardManager {
    NSParameterAssert(appContext);
    NSParameterAssert(window);
    NSParameterAssert(keyboardManager);
    
    self = [super init];
    if (self) {
        _appContext = appContext;
        _window = window;
        _keyboardManager = keyboardManager;
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
    self.keyboardManager.enable = YES;
}

#pragma mark - NavigationBarItems


- (void)didTapSearchButton:(id)sender {
    LocationSearchViewController *searchVC = [[LocationSearchViewController alloc] initWithViewModel:[LocationSearchViewModel new]];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self.window.rootViewController presentViewController:navVC animated:YES completion:nil];
}

@end
