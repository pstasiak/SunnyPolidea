//
//  LocationSearchViewModel.m
//  Sunny
//
//  Created by Przemek on 31.08.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "LocationSearchViewModel.h"

@interface LocationSearchViewModel ()
@property (nonatomic, assign) BOOL byNameSearchEnabled;
@property (nonatomic, assign) BOOL byLocationSearchEnabled;
@end

@implementation LocationSearchViewModel

- (void)setLocationName:(NSString *)locationName {
    DidUpdateCopyPropertyImplementation(locationName, ^{
        [self updateByNameSearchEnabled];
    })
}

- (void)setByNameSearchEnabled:(BOOL)byNameSearchEnabled {
    DidUpdateAssignPropertyImplementation(byNameSearchEnabled, ^{
        [self informDidUpdate];
    })
}

- (void)updateByNameSearchEnabled {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .";
    NSCharacterSet *notLetters = [[NSCharacterSet characterSetWithCharactersInString:letters] invertedSet];
    NSRange range = [self.locationName rangeOfCharacterFromSet:notLetters];
    self.byNameSearchEnabled = self.locationName.length > 0 && range.location == NSNotFound;
}

- (void)informDidUpdate {
    if (self.updateBlock) {
        self.updateBlock(self);
    }
}

@end
