//
// Created by Maciej Oczko on 06/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "LocationServiceFake.h"

@implementation LocationServiceFake

- (void)setOnUpdateBlock:(LocationServiceUpdateBlock)onUpdateBlock {
    onUpdateBlock(self.currentLocation, self.error);
}

@end
