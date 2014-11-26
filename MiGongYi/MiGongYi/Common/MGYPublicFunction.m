//
//  MGYPublicFunction.m
//  MiGongYi
//
//  Created by megil on 11/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYPublicFunction.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MGYPublicFunction

+ (NSString *)signStringWithMD5:(NSDictionary *)parameters
{
    NSArray *sortArray = [parameters allKeys];
    sortArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    NSMutableString *string = [NSMutableString string];
    BOOL isFirstKey = YES;
    for (NSString *key in sortArray) {
        if(isFirstKey)
        {
            isFirstKey = NO;
        }else
        {
            [string appendString:@"&"];
        }
        [string appendFormat:@"%@=%@", key, [parameters objectForKey:key]];
    }
    [string appendFormat:@"4Gcna@DcbEqkb!gqc@3"];
    const char *str = [string UTF8String];
    unsigned char r[16];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSMutableString* sha512 = [[NSMutableString alloc] init];
    for (int i = 0 ; i < 16 ; ++i)
    {
        [sha512 appendFormat: @"%02x", r[i]];
    }

    return sha512;
}

@end
