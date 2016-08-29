//
// Created by Maciej Oczko on 25/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "WeatherViewCell.h"
#import "WeatherServiceItem.h"

@interface WeatherViewCell ()
@property(nonatomic, readwrite) UILabel *descriptionLabel;
@property(nonatomic, readwrite) UILabel *valueLabel;
@property(nonatomic) BOOL didSetupConstraints;
@end

@implementation WeatherViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *descriptionLabel = [UILabel new];
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
        
        UILabel *valueLabel = [UILabel new];
        valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:valueLabel];
        self.valueLabel = valueLabel;

        [self setNeedsUpdateConstraints];
    }

    return self;
}

- (void)configureWithItem:(WeatherServiceItem *)item {
    self.descriptionLabel.text = item.name;
    self.valueLabel.text = item.formattedValue;
    [self setNeedsLayout];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        self.didSetupConstraints = YES;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[description]-(>=0)-[value]-|"
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:nil
                                                                       views:@{
                                                                               @"description" : self.descriptionLabel,
                                                                               @"value" : self.valueLabel,
                                                                       }]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
    }
    
    [super updateConstraints];
}

@end
