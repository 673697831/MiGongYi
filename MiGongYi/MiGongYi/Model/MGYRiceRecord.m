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
             @"description": @"description",
             @"incOrDec": @"incOrDec",
             @"riceNum" : @"riceNum",
             @"time" : @"time",
             };
}

@end
