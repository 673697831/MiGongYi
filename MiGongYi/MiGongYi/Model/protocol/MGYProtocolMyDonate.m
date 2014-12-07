//
//  MGYProtocolMyDonate.m
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProtocolMyDonate.h"

@implementation MGYProtocolMyDonate

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"aboutItemDesc": @"about_item_desc",
             @"attendStatus": @"attend_status",
             @"joinMemberNum": @"join_member_num",
             @"myDonateProject": @"my_donate_project",
             @"myDonateProjectRice": @"my_donate_project_rice",
             @"myDonateRice": @"my_donate_rice",
             @"myRice": @"my_rice",
             @"progress": @"progress",
             @"projectId": @"project_id",
             @"riceTotal": @"rice_total",
             @"share": @"share",
             @"status": @"status",
             @"summary": @"summary",
             @"title": @"title",
             @"userLevel": @"user_level",
             };
}

+ (NSValueTransformer *)shareJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYShare class]];
}

@end
