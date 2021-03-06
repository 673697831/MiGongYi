//
//  MGYMiChatRecord.m
//  MiGongYi
//
//  Created by megil on 10/9/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatRecord.h"

@implementation MGYMiChatRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"personName" : @"personName",
             @"totalTimes" : @"totalTimes",
             @"currentTimes" : @"currentTimes",
             @"phoneList" : @"phoneList",
             @"completed" : @"completed",
             };
}

@end
