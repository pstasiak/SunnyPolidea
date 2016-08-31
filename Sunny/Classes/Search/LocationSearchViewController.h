//
//  LocationSearchViewController.h
//  Sunny
//
//  Created by Przemek on 29.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Metamacros.h"

NS_ASSUME_NONNULL_BEGIN

@class LocationSearchViewModel;

@interface LocationSearchViewController : UIViewController

MM_EMPTY_INIT_UNAVAILABLE

- (instancetype)initWithViewModel:(LocationSearchViewModel *)viewModel NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
