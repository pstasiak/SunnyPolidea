//
// Created by Maciej Oczko on 06/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject
- (BOOL)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
