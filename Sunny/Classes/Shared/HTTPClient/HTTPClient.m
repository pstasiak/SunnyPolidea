//
// Created by Maciej Oczko on 06/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "HTTPClient.h"
#import "AFHTTPSessionManager.h"
#import "Metamacros.h"

@interface HTTPClient ()
@property(nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;
@end

@implementation HTTPClient

LazyProperty(AFHTTPSessionManager *, sessionManager, ^{
    return [AFHTTPSessionManager manager];
})

- (BOOL)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:URLString
                                                   parameters:parameters
                                                     progress:nil
                                                      success:success
                                                      failure:failure];
    [dataTask resume];
    return YES;
}

@end
