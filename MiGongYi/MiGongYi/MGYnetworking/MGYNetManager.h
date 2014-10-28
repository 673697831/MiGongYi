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
                 success:(MGYNetOperationSuccess)success
                 failure:(MGYNetOperationFailure)failure;

- (MGYNetOperation *)POST:(NSString *)URLString
               parameters:(id)parameters
                  success:(MGYNetOperationSuccess)success
                  failure:(MGYNetOperationFailure)failure;

+ (instancetype)manager;

@end
