//
//  MGYNetRequestSerialization.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetRequestSerializer.h"

@implementation MGYNetRequestSerializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stringEncoding = NSUTF8StringEncoding;
//        self.allowsCellularAccess = YES;
//        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//        self.HTTPShouldHandleCookies = YES;
//        self.HTTPShouldUsePipelining = NO;
//        self.networkServiceType = NSURLNetworkServiceTypeDefault;
//        self.timeoutInterval = 60;
//        
//        self.mutableHTTPRequestHeaders = [NSMutableDictionary dictionary];
//        
//        // Accept-Language HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
//        NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
//        [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            float q = 1.0f - (idx * 0.1f);
//            [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
//            *stop = q <= 0.5f;
//        }];
//        [self setValue:[acceptLanguagesComponents componentsJoinedByString:@", "] forHTTPHeaderField:@"Accept-Language"];
//        
//        NSString *userAgent = nil;
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
//        // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
//        userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
//#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
//        userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
//#endif
//#pragma clang diagnostic pop
//        if (userAgent) {
//            if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
//                NSMutableString *mutableUserAgent = [userAgent mutableCopy];
//                if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
//                    userAgent = mutableUserAgent;
//                }
//            }
//            [self setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//        }
//        
//        // HTTP Method Definitions; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
        self.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
    }
    
    return self;
}

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
    //mutableRequest.allowsCellularAccess = self.allowsCellularAccess;
    //mutableRequest.cachePolicy = self.cachePolicy;
    mutableRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    //mutableRequest.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies;
    //mutableRequest.HTTPShouldUsePipelining = self.HTTPShouldUsePipelining;
    //mutableRequest.networkServiceType = self.networkServiceType;
    //mutableRequest.timeoutInterval = self.timeoutInterval;
    mutableRequest.timeoutInterval = 10;
    mutableRequest = [[self requestBySerializingRequest:mutableRequest withParameters:parameters error:nil] mutableCopy];
    
	return mutableRequest;
}

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
    //mutableRequest.URL = [NSURL URLWithString:[[mutableRequest.URL absoluteString] stringByAppendingFormat:mutableRequest.URL.query ? @"&%@" : @"?%@", [self parametersToString:parameters]]];
//    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
//        if (![request valueForHTTPHeaderField:field]) {
//            [mutableRequest setValue:value forHTTPHeaderField:field];
//        }
//    }];
    
//    if (parameters) {
//        NSMutableArray *mutablePairs = [NSMutableArray array];
//        for (id pair in AFQueryStringPairsFromDictionary(parameters)) {
//            [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
//        }
//        
//        NSString *query = [mutablePairs componentsJoinedByString:@"&"];
//        query = AFQueryStringFromParametersWithEncoding(parameters, self.stringEncoding);
//        if (self.queryStringSerialization) {
//            query = self.queryStringSerialization(request, parameters, error);
//        } else {
//            switch (self.queryStringSerializationStyle) {
//                case AFHTTPRequestQueryStringDefaultStyle:
//                    query = AFQueryStringFromParametersWithEncoding(parameters, self.stringEncoding);
//                    break;
//            }
//        }
//        
//        if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
//            mutableRequest.URL = [NSURL URLWithString:[[mutableRequest.URL absoluteString] stringByAppendingFormat:mutableRequest.URL.query ? @"&%@" : @"?%@", query]];
//        } else {
//            if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
//                NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
//                [mutableRequest setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
//            }
//            [mutableRequest setHTTPBody:[query dataUsingEncoding:self.stringEncoding]];
//        }
//    }
    
    return mutableRequest;
}

- (NSString *)parametersToString:(NSDictionary *)parameters
{
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (NSString *key in parameters) {
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, [parameters objectForKey:key]];
        [mutablePairs addObject:str];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

+ (instancetype)serializer
{
    return [MGYNetRequestSerializer new];
}

@end
