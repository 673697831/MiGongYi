//
//  MGYProtocolRiceBoxingObtain.m
//  MiGongYi
//
//  Created by megil on 11/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProtocolRiceBoxingObtain.h"

@implementation MGYProtocolRiceBoxingObtain

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"remainTimes": @"remain_times",
             @"arrayProcess": @"process",
             @"dailyTips": @"description",
             };
}

@end
