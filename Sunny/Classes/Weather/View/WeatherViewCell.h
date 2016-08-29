//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configurable.h"

@interface WeatherViewCell : UICollectionViewCell <Configurable>
@property(nonatomic, readonly) UILabel *descriptionLabel;
@property(nonatomic, readonly) UILabel *valueLabel;
@end
