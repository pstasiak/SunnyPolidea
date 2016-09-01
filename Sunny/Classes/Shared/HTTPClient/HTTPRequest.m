//
//  HTTPRequest.m
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest

- (NSURLSessionDataTask *)sendWithHTTPClient:(HTTPClient *)client completion:(void (^)(id, NSError *))completion {
    NSAssert(false, @"Should be implemented by HTTPRequest subclass");
    return nil;
}

@end
