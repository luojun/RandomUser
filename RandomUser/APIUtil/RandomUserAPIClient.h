//
//  RestAPIClient.h
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RandomUserAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
