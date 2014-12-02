//
//  MGYPublicFunction.h
//  MiGongYi
//
//  Created by megil on 11/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MGYPublicFunction : NSObject

typedef void (^MGYSuccess)();
typedef void (^MGYGainRiceSuccess)(NSInteger);
typedef void (^MGYFailure)(NSError *);
typedef void (^MGYRiceTimeOutFailure)();
typedef void (^MGYRiceBoxingTimeBlock)();

typedef void (^afNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, NSDictionary * responseObject);

typedef void (^afNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

+ (NSString *)signStringWithMD5:(NSDictionary *)parameters;

+ (NSDictionary *)md5Parameters:(NSDictionary *)parameters;

@end
