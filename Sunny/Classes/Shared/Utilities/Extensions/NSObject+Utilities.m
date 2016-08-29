//
// Created by Maciej Oczko on 22/05/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

- (NSString *)className {
    return [[self class] className];
}

@end
