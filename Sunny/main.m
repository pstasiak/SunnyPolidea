//
//  main.m
//  Sunny
//
//  Created by Maciej Oczko on 22/05/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestingAppDelegate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        if (isRunningTests()) {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([TestingAppDelegate class]));
        } else {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
}
