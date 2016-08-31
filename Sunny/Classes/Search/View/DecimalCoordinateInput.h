//
//  DecimalCoordinateInput.h
//  Sunny
//
//  Created by Przemek on 31.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE @interface DecimalCoordinateInput : UIView

@property(nonatomic, strong, readonly) UILabel *textLabel;
@property(nonatomic, strong, readonly) UITextField *textField;
@property(nonatomic, strong, readonly) UISegmentedControl *signControl;

@end

NS_ASSUME_NONNULL_END
