//
// Created by Maciej Oczko on 06/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   completion:(void (^)(id responseObject, NSError *error))completion;

@end
