//
//  DecimalCoordinateInput.m
//  Sunny
//
//  Created by Przemek on 31.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "DecimalCoordinateInput.h"

@interface DecimalCoordinateInput ()
@property(nonatomic, strong) IBOutlet UILabel *textLabel;
@property(nonatomic, strong) IBOutlet UITextField *textField;
@property(nonatomic, strong) IBOutlet UISegmentedControl *signControl;
@property(nonatomic, strong) IBOutlet UIView *contentView;
@end

@implementation DecimalCoordinateInput

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupAfterInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAfterInit];
    }
    return self;
}

- (void)setupAfterInit {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.contentView];
}

@end
