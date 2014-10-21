//
//  MGYNetRequestSerialization.h
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGYNetRequestSerializer : NSObject

@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSSet *HTTPMethodsEncodingParametersInURI;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters;

+ (instancetype)serializer;

@end
