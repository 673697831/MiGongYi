//
//  MGYNetOperation.h
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYNetOperation : NSOperation

typedef void (^MGYNetOperationSuccess)(MGYNetOperation *, id);
typedef void (^MGYNetOperationFailure)(MGYNetOperation *, NSError *);

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(MGYNetOperationSuccess)success
                        failure:(MGYNetOperationFailure)failure;

@end
