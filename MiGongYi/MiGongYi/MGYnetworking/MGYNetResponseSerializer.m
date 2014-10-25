//
//  MGYNetResponseSerializer.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetResponseSerializer.h"

@implementation MGYNetResponseSerializer


- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
}

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    BOOL responseIsValid = YES;
    //NSError *validationError = nil;
    
//    if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
//        if (self.acceptableContentTypes && ![self.acceptableContentTypes containsObject:[response MIMEType]]) {
//            if ([data length] > 0) {
//                NSDictionary *userInfo = @{
//                                           NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: unacceptable content-type: %@", @"AFNetworking", nil), [response MIMEType]],
//                                           NSURLErrorFailingURLErrorKey:[response URL],
//                                           AFNetworkingOperationFailingURLResponseErrorKey: response
//                                           };
//                
//                validationError = AFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo], validationError);
//            }
//            
//            responseIsValid = NO;
//        }
//        
//        if (self.acceptableStatusCodes && ![self.acceptableStatusCodes containsIndex:(NSUInteger)response.statusCode]) {
//            NSDictionary *userInfo = @{
//                                       NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: %@ (%ld)", @"AFNetworking", nil), [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode], (long)response.statusCode],
//                                       NSURLErrorFailingURLErrorKey:[response URL],
//                                       AFNetworkingOperationFailingURLResponseErrorKey: response
//                                       };
//            
//            validationError = AFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorBadServerResponse userInfo:userInfo], validationError);
//            
//            responseIsValid = NO;
//        }
//    }
//    
//    if (error && !responseIsValid) {
//        *error = validationError;
//    }
    
    return responseIsValid;
}

+ (instancetype)serializer
{
    return [MGYNetResponseSerializer new];
}

@end
