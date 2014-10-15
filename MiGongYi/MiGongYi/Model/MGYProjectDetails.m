//
//  MGYProjectDetails.m
//  MiGongYi
//
//  Created by megil on 9/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProjectDetails.h"

@implementation MGYProjectDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"projectId": @"project_id",
             @"detailImg": @"detail_img",
             @"title": @"title",
             @"subtitle": @"subtitle",
             @"summary": @"summary",
             @"riceDonate": @"rice_donate",
             @"progress":@"progress",
             @"type":@"type",
             @"favNum":@"fav_num",
             @"joinMemberNum":@"join_member_num",
             @"donor":@"donor",
             @"recipient":@"recipient",
             @"resource":@"resource",
             @"status":@"status",
             @"readmoreUrl":@"readmore_url",
             @"fav":@"fav",
             @"helpMemberNum":@"help_member_num",
             @"commentExist":@"comment_exist",
             @"share":@"share",
             };
}

+ (NSValueTransformer *)donorJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYProjectDetailsDonorOrRecipient class]];
}

+ (NSValueTransformer *)recipientJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYProjectDetailsDonorOrRecipient class]];
}

+ (NSValueTransformer *)resourceJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYProjectDetailsResource class]];
}

+ (NSValueTransformer *)shareJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MGYShare class]];
}

@end

@implementation MGYProjectDetailsDonorOrRecipient

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"showImg": @"show_img",
             @"title": @"title",
             };
}

@end

@implementation MGYProjectDetailsResource

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"resourceName": @"resource_name",
             @"resourceNum": @"resource_num",
             };
}

@end
