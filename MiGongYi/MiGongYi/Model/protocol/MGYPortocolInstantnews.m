//
//  MGYPortocolInstantnews.m
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYPortocolInstantnews.h"

@implementation MGYPortocolInstantnewsComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"avatar": @"avatar",
             @"content": @"content",
             @"nickname": @"nickname",
             @"time": @"time",
             @"type": @"type",
             };
}

+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
            @{@(1):@(MGYInstantnewsCommentTypeUser), @(2):@(MGYInstantnewsCommentTypeSystem),
               @(3):@(MGYInstantnewsCommentTypeDonateSuccess)}];
}

@end

@implementation MGYPortocolInstantnews

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"lastGetTime": @"last_get_time",
             @"rs": @"rs",
             };
}

+ (NSValueTransformer *)rsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYPortocolInstantnewsComment class]];
}

@end
