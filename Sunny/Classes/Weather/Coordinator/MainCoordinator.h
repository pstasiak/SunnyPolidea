//
//  MainCoordinator.h
//  Sunny
//
//  Created by Przemek on 29.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "metamacros.h"

NS_ASSUME_NONNULL_BEGIN

@class AppContext;

@interface MainCoordinator : NSObject
MM_EMPTY_INIT_UNAVAILABLE
- (instancetype)initWithAppContext:(AppContext *)appContext
                            window:(UIWindow *)window NS_DESIGNATED_INITIALIZER;
- (void)start;

@end

NS_ASSUME_NONNULL_END
