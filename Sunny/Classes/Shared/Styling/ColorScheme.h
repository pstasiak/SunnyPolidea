//
//  ColorScheme.h
//  Sunny
//
//  Created by Przemek on 29.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

@protocol ColorSchemeProtocol
@property(nonatomic, readonly) UIColor *mainBackgroundColor;
@end

@interface ColorScheme : NSObject <ColorSchemeProtocol>

@end
