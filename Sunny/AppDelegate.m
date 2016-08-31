//
//  AppDelegate.m
//  Sunny
//
//  Created by Maciej Oczko on 22/05/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "AppDelegate.h"
#import "Metamacros.h"
#import "AppContext.h"
#import "MainCoordinator.h"

@interface AppDelegate ()
@property(nonatomic, strong, readwrite) AppContext *appContext;
@property(nonatomic, strong) MainCoordinator *coordinator;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.coordinator = [[MainCoordinator alloc] initWithAppContext:self.appContext
                                                            window:self.window];
    [self.coordinator start];
    return YES;
}

LazyProperty(AppContext *, appContext, ^{
    return [AppContext new];
})

LazyProperty(UIWindow *, window, ^{
    return [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
})

@end
