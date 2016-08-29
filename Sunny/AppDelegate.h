//
//  AppDelegate.h
//  Sunny
//
//  Created by Maciej Oczko on 22/05/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppContext;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong, readonly) AppContext *appContext;
@end

