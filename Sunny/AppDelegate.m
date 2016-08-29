//
//  AppDelegate.m
//  Sunny
//
//  Created by Maciej Oczko on 22/05/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "Metamacros.h"
#import "AppContext.h"

@interface AppDelegate ()
@property(nonatomic, strong, readwrite) AppContext *appContext;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WeatherViewController *weatherViewController = [self.appContext weatherViewController];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:weatherViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

LazyProperty(AppContext *, appContext, ^{
    return [AppContext new];
})

LazyProperty(UIWindow *, window, ^{
    return [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
})

@end
