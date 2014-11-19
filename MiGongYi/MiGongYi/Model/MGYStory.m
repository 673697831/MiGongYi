//
//  MGYStory.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStory.h"

@implementation MGYStory

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)arrayBuffJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYStoryBuff class]];
}

@end
