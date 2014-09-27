//
//  MGYRiceFlow.m
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceFlow.h"

@implementation MGYRiceFlow

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"riceRemain": @"rice_remain",
             @"rs": @"rs",
             };
}

//+ (NSValueTransformer *)rsJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MGYRiceRecord.class];
//}

@end
