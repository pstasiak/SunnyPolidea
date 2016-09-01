//
//  HTTPRequest.h
//  Sunny
//
//  Created by Przemek on 01.09.2016.
//  Copyright © 2016 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPClient;
//@protocol HTTPRequestProtocol <NSObject>
//
//@property(nonatomic, readonly, nullable) NSDictionary *parameters;
//@property(nonatomic, readonly) NSString *URLString;
//
//@end

@interface HTTPRequest<ResultType> : NSObject
- (NSURLSessionDataTask *)sendWithHTTPClient:(HTTPClient *)client completion:(void (^)(ResultType result, NSError *error))completion;
@end

