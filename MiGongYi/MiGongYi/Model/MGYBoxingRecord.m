//
//  MGYBoxing.m
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYBoxingRecord.h"

@implementation MGYMonster

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

@end

@implementation MGYBoxingRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"fightTimes" : @"fightTimes",
             @"timesp" : @"timesp",
             @"arrayMonster" : @"arrayMonster",
             @"monsterId" : @"monsterId",
             @"curHp" : @"curHp",
             };
}


+ (NSValueTransformer *)arrayMonsterJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYMonster class]];
}

@end
