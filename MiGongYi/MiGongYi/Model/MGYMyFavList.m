//
//  MGYMyFavList.m
//  MiGongYi
//
//  Created by megil on 9/26/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMyFavList.h"

@implementation MGYMyFavList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"count": @"count",
             @"rs": @"rs",
             };
}

+ (NSValueTransformer *)rsJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MGYMyFav class]];
}

@end

@implementation MGYMyFav

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"time": @"time",
             @"title": @"title",
             @"projectId": @"project_id",
             @"projectThumb": @"project_thumb",
             };
}

@end
