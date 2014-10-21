//
//  MGYNetManager.h
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYNetOperation.h"

@interface MGYNetManager : NSObject

- (MGYNetOperation *)GET:(NSString *)URLString
              parameters:(id)parameters
                 success:(MGYNetSuccess)success
                 failure:(MGYNetFailure)failure;

- (MGYNetOperation *)POST:(NSString *)URLString
               parameters:(id)parameters
                  success:(MGYNetSuccess)success
                  failure:(MGYNetFailure)failure;

+ (instancetype)manager;

@end
