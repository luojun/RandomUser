//
//  RestAPIClient.m
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "RandomUserAPIClient.h"
#import "RandomUserProcessor.h"

@implementation RandomUserAPIClient

static NSString * const RandomUserAPIBaseURLString = @"http://api.randomuser.me";

+ (instancetype)sharedClient {
    static RandomUserAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RandomUserAPIClient alloc] initWithBaseURL:[NSURL URLWithString:RandomUserAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

        // run completion blocks on a background queue
        _sharedClient.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    });
    
    return _sharedClient;
}

+ (NSURLSessionDataTask *)requestRandomUserWithBlock:(void (^)(NSError *error))block {
    return [[RandomUserAPIClient sharedClient] GET:@"" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary *randomUserData = [[[JSON valueForKeyPath:@"results"] objectAtIndex:0] valueForKeyPath:@"user"];
        [RandomUserProcessor processData:randomUserData];
        if (block) {
            block(nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

@end
