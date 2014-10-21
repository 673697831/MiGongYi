//
//  MGYNetOperation.h
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYNetOperation : NSOperation <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

typedef void (^MGYNetSuccess)(MGYNetOperation *, id);
typedef void (^MGYNetFailure)(MGYNetOperation *, NSError *);

@property (nonatomic, copy) MGYNetSuccess success;
@property (nonatomic, copy) MGYNetFailure failure;

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest;

- (void)start;

@end
