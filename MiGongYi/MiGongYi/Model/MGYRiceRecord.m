//
//  MGYRiceRecord.m
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceRecord.h"

@implementation MGYRiceRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"des": @"description",
             @"incOrDec": @"inc_or_dec",
             @"riceNum" : @"rice_num",
             @"time" : @"time",
             };
}

+ (NSValueTransformer *)incOrDecJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:
  @{@(1):@(MGYRiceRecordModeInc), @(2):@(MGYRiceRecordModeDec)}];
}

@end
