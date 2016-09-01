//
//  LocationSearchViewModel.h
//  Sunny
//
//  Created by Przemek on 31.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Metamacros.h"

@protocol LocationSearchViewDataProtocol <NSObject>

@property (nonatomic, readonly) BOOL byNameSearchEnabled;
@property (nonatomic, readonly) BOOL byLocationSearchEnabled;

@end

NS_ASSUME_NONNULL_BEGIN

@class WeatherServiceLocation;

typedef void (^LocationSearchViewDataUpdateBlock)(id<LocationSearchViewDataProtocol>viewModel);
typedef void (^LocationSearchCompletionBlock)(WeatherServiceLocation *location, NSError *error);

@interface LocationSearchViewModel : NSObject <LocationSearchViewDataProtocol>

@property (nonatomic, copy, nullable) NSString *locationName;
@property (nonatomic, copy) LocationSearchViewDataUpdateBlock updateBlock;

- (void)searchForLocationNameWithCompletion:(LocationSearchCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
