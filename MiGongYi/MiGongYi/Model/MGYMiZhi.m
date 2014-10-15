//
//  MGYMiZhi.m
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiZhi.h"

@implementation MGYMiZhi

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dailyId" : @"daily_id",
             @"dailyTitle" : @"daily_title",
             @"dailyImg" : @"daily_img",
             @"content" : @"content",
             @"miZhiShare" : @"share",
             };
}

+ (NSValueTransformer *)miZhiShareJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYShare class]];
}

@end
