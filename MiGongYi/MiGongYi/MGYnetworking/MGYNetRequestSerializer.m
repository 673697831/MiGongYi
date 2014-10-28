//
//  MGYNetRequestSerialization.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetRequestSerializer.h"

@interface MGYNetRequestSerializer ()

@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSSet *HTTPMethodsEncodingParametersInURI;

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError * __autoreleasing *)error;
- (NSString *)parametersToString:(NSDictionary *)parameters;

@end

@implementation MGYNetRequestSerializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stringEncoding = NSUTF8StringEncoding;
        self.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
    }
    
    return self;
}

#pragma mark -
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
{
    NSParameterAssert(method);
    NSParameterAssert(URLString);
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSParameterAssert(url);
    
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = method;
    mutableRequest.timeoutInterval = 10;
    mutableRequest = [[self requestBySerializingRequest:mutableRequest withParameters:parameters error:nil] mutableCopy];
    
	return mutableRequest;
}

#pragma mark -
- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError * __autoreleasing *)error
{
    NSParameterAssert(request);
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *query = [self parametersToString:parameters];
    if (parameters) {
        if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
            mutableRequest.URL = [NSURL URLWithString:[[mutableRequest.URL absoluteString] stringByAppendingFormat:mutableRequest.URL.query ? @"&%@" : @"?%@", query]];
        } else {
            if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
                NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
                [mutableRequest setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
            }
            [mutableRequest setHTTPBody:[query dataUsingEncoding:self.stringEncoding]];
        }
    }
    
    return mutableRequest;
}

- (NSString *)parametersToString:(NSDictionary *)parameters
{
    NSMutableString *string = [NSMutableString string];
    BOOL isFirstKey = YES;
    for (NSString *key in parameters) {
        if(isFirstKey)
        {
            isFirstKey = NO;
        }else
        {
            [string appendString:@"&"];
        }
        [string appendFormat:@"%@=%@", key, [parameters objectForKey:key]];
    }
    
//    NSMutableArray *mutablePairs = [NSMutableArray array];
//    for (NSString *key in parameters) {
//        NSString *str = [NSString stringWithFormat:@"%@=%@", key, [parameters objectForKey:key]];
//        [mutablePairs addObject:str];
//    }
//    
//    return [mutablePairs componentsJoinedByString:@"&"];
    return string;
}

#pragma mark -
+ (instancetype)serializer
{
    return [MGYNetRequestSerializer new];
}

@end
