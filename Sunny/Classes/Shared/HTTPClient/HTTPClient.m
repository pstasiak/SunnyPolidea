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

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                   completion:(void (^)(id responseObject, NSError *error))completion {
    NSURLSessionDataTask *dataTask =
    [self.sessionManager GET:URLString
                   parameters:parameters
                     progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         completion == nil ?: completion(responseObject, nil);
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         completion == nil ?: completion(nil, error);
                     }];
    [dataTask resume];
    return dataTask;
}

@end
