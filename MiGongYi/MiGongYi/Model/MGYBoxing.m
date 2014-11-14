//
//  MGYBoxing.m
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYBoxing.h"

@implementation MGYMonster

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"fightTimes" : @"fightTimes",
             @"monsterId" : @"monsterId",
             @"monsterType" : @"monsterType",
             @"monsterName" : @"monsterName",
             @"rateContent" : @"rateContent",
             @"maxHp" : @"maxHp",
             @"riceNum" : @"riceNum",
             @"skillContent" : @"skillContent",
             @"levelContent" : @"levelContent",
             @"storyContent" : @"storyContent",
             @"gayImagePath" : @"gayImagePath",
             @"normalImagePath" : @"normalImagePath",
             @"monsterStatus" : @"monsterStatus"
             };
}

@end

@implementation MGYBoxing

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
