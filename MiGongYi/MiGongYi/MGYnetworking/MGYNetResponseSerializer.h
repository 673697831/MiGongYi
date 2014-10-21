//
//  MGYNetResponseSerializer.h
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYNetResponseSerializer : NSObject

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error;

+ (instancetype)serializer;

@end
